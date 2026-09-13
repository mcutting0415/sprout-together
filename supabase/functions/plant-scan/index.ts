// Supabase Edge Function: plant-scan
//
// Photo -> plant identification, or photo -> problem diagnosis, via Claude.
//
// Runs server-side for two reasons:
//   1. The Anthropic API key must never ship in the app bundle. Anything in a
//      Flutter binary can be extracted, and a leaked key is billed to us.
//   2. Entitlement and quota have to be checked somewhere the client can't lie.
//      Pro status is read from RevenueCat here, not trusted from the request.
//
// Deploy:
//   supabase functions deploy plant-scan
//   supabase secrets set ANTHROPIC_API_KEY=sk-ant-...
//   supabase secrets set REVENUECAT_SECRET_KEY=sk_...
// (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY are injected by the platform.)

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
// npm: specifier rather than esm.sh  -  the Anthropic SDK pulls in enough Node
// built-ins that the esm.sh build fails to boot in the edge runtime.
import Anthropic from "npm:@anthropic-ai/sdk@0.123.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

// One constant so the model can be changed without an app release.
const MODEL = "claude-opus-5";

// Scans a non-Pro user gets before the paywall.
//
// Deliberately not 0. Entitlement detection is not yet trustworthy: RevenueCat
// was never keyed on the Supabase user id (fixed app-side in 5cd8bb4, but that
// only takes effect once users are on the new build), and with a 0 allowance a
// failed lookup means nobody can scan at all - which is what happened during
// testing. A small allowance means the feature works for everyone even when
// the entitlement check is wrong, and it doubles as a genuine free trial.
//
// Drop this to 0 once the logs show comped/pro resolving correctly for real
// users. It is server-side, so changing it needs a redeploy, not a release.
const FREE_SCAN_LIMIT = 3;

// Comped accounts: these Supabase user ids skip the Pro check entirely.
// For the owner, family, and anyone reviewing the app. The daily cap below
// still applies to them, so a comp can't become an unbounded bill either.
// Adding someone needs a function redeploy, not an app release.
const COMPED_USER_IDS = new Set<string>([
  "e5b72a57-52b9-4782-83c6-a363d82390d9", // Mackenzie (owner)
  "e1823ae0-fd1a-4fdb-8afc-a45cb6ce6b94", // family
]);

// Hard ceiling per user per day, Pro included  -  protects against a runaway
// client loop turning into an unbounded bill.
const DAILY_CAP = 40;

const MAX_IMAGE_BYTES = 5 * 1024 * 1024;
const ALLOWED_MEDIA = ["image/jpeg", "image/png", "image/webp"];

const IDENTIFY_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: [
    "is_plant",
    "common_name",
    "confidence",
    "summary",
    "identifying_features",
    "next_steps",
  ],
  properties: {
    is_plant: {
      type: "boolean",
      description: "False if the photo does not show a plant at all.",
    },
    common_name: {
      type: "string",
      description:
        "The everyday name ONLY, two or three words at most, e.g. 'Wild potato vine'. No parentheses, no alternate names, no scientific name. This is rendered as a page heading and a long value breaks the layout.",
    },
    also_known_as: {
      type: "array",
      items: { type: "string" },
      description: "Other common names, if any. Empty array if none.",
    },
    scientific_name: { type: "string" },
    plant_family: { type: "string", description: "e.g. 'Convolvulaceae'." },
    confidence: { type: "string", enum: ["high", "medium", "low"] },
    summary: {
      type: "string",
      description:
        "Two or three sentences on what it is and where it grows. Do not describe the photo quality here.",
    },
    identifying_features: {
      type: "array",
      items: { type: "string" },
      description:
        "Two to four specific things visible in the photo that led to this identification - leaf shape, flower form, stem colour.",
    },
    look_alikes: {
      type: "array",
      items: { type: "string" },
      description:
        "Plants this is commonly confused with, and the one detail that separates them. Empty array if none.",
    },
    edible_or_toxic: {
      type: "string",
      description:
        "Plain-language safety note. Say clearly if any part is toxic to people, pets or livestock, and if edible say which part and how it is prepared. Say 'Not known to be toxic' only when that is accurate. Never encourage eating a plant identified from a photo.",
    },
    is_weed_or_invasive: {
      type: "string",
      description:
        "Whether gardeners usually treat this as a weed, a wildflower, or a cultivated plant, and whether it spreads aggressively.",
    },
    care_snapshot: {
      type: "object",
      additionalProperties: false,
      required: ["sun", "water", "spacing"],
      properties: {
        sun: { type: "string" },
        water: { type: "string" },
        spacing: { type: "string" },
      },
    },
    next_steps: {
      type: "array",
      items: { type: "string" },
      description: "Two to four short, concrete actions for the grower.",
    },
    photo_caveat: {
      type: "string",
      description:
        "Only if the photo genuinely limits confidence (blurry, a screen, only one leaf). Empty string otherwise. Kept separate so it does not clutter the description.",
    },
  },
} as const;

const DIAGNOSE_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: [
    "is_plant",
    "looks_healthy",
    "problem",
    "severity",
    "confidence",
    "likely_causes",
    "treatment",
    "prevention",
  ],
  properties: {
    is_plant: { type: "boolean" },
    looks_healthy: {
      type: "boolean",
      description: "True when nothing is visibly wrong.",
    },
    plant_guess: {
      type: "string",
      description:
        "What the plant appears to be, in lowercase, short, no parentheses, e.g. 'young cherry or plum tree'. It is shown mid-sentence after 'Looks like'.",
    },
    problem: {
      type: "string",
      description:
        "The name of the problem ONLY, two or three words, e.g. 'Gummosis' or 'Early blight'. No parentheses, no explanation. This is rendered as a page heading and anything longer breaks the layout; the explanation belongs in likely_causes.",
    },
    severity: { type: "string", enum: ["none", "low", "medium", "high"] },
    confidence: { type: "string", enum: ["high", "medium", "low"] },
    likely_causes: { type: "array", items: { type: "string" } },
    treatment: {
      type: "array",
      items: { type: "string" },
      description: "Ordered steps, most important first.",
    },
    prevention: { type: "array", items: { type: "string" } },
  },
} as const;

const IDENTIFY_PROMPT = `You identify plants from photographs for a home gardening app.

Give a genuinely useful answer, not a label. Someone photographing an unknown plant wants to know what it is, how sure you are, whether it is safe, and what to do with it.

Rules:
- common_name is a heading. Two or three words, no parentheses, no alternate names. Extra names go in also_known_as.
- Say what in the photo led you there - leaf shape, flower form, stem colour. That is what lets someone check your work.
- Be honest about uncertainty. A blurry photo or a single leaf often cannot be pinned down; say "low" and name the most likely candidate. A confident wrong answer sends someone to plant, pull or eat the wrong thing.
- If the photo limits you, put that in photo_caveat, not in the summary.
- edible_or_toxic matters. Flag anything toxic to people, pets or livestock plainly. Never encourage eating a plant identified from a photo.
- Note whether gardeners usually treat it as a weed, a wildflower, or something cultivated.
- If it is not a plant, set is_plant false and leave the rest empty.

No preamble.`;

const DIAGNOSE_PROMPT = `You diagnose plant problems from photographs for a home gardening app.

Work from what is actually visible: leaf colour and pattern, spotting, wilting, insect damage, the growing medium. Name the most likely problem and say plainly how confident you are.

Rules that matter:
- If the plant looks fine, say so  -  set looks_healthy true and severity "none". Do not invent a problem to seem useful.
- Many symptoms have several causes (over- and under-watering look alike). List the real candidates instead of committing to one.
- Prefer cultural fixes (watering, spacing, airflow, removing affected leaves) before chemical ones.
- If you recommend any treatment that could harm people, pets or pollinators, say so in that step.
- problem is a heading: the name only, two or three words, no parentheses. Put what it means in likely_causes.
- plant_guess is inserted mid-sentence, so write it lowercase and short.
- If the photo does not show a plant, set is_plant to false.

Keep every step short and actionable. No preamble.`;

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    // charset matters: without it the client may decode UTF-8 as Latin-1 and
    // an em-dash arrives as mojibake in the middle of a sentence.
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json; charset=utf-8",
    },
  });
}

/** Ask RevenueCat whether this user holds the Pro entitlement. */
async function isProUser(userId: string): Promise<boolean> {
  const key = Deno.env.get("REVENUECAT_SECRET_KEY");
  if (!key) return false;
  try {
    const res = await fetch(
      `https://api.revenuecat.com/v1/subscribers/${encodeURIComponent(userId)}`,
      { headers: { Authorization: `Bearer ${key}` } },
    );
    if (!res.ok) return false;
    const body = await res.json();
    const ent = body?.subscriber?.entitlements?.["SproutTogether Pro"];
    if (!ent) return false;
    const expires = ent.expires_date ? Date.parse(ent.expires_date) : null;
    return expires === null || expires > Date.now();
  } catch {
    // Never hard-fail a scan because RevenueCat is down; treat as non-Pro so
    // the free allowance still applies.
    return false;
  }
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }
  if (req.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }

  const authHeader = req.headers.get("Authorization") ?? "";
  console.log(`[plant-scan] request method=${req.method} hasAuth=${authHeader.startsWith("Bearer ")}`);
  if (!authHeader.startsWith("Bearer ")) {
    console.log("[plant-scan] denied: no bearer token");
    return json({ error: "unauthorized" }, 401);
  }

  const admin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { data: userData, error: userErr } = await admin.auth.getUser(
    authHeader.replace("Bearer ", ""),
  );
  if (userErr || !userData?.user) {
    console.log(`[plant-scan] denied: getUser failed  -  ${userErr?.message ?? "no user"}`);
    return json({ error: "unauthorized" }, 401);
  }
  const userId = userData.user.id;
  console.log(`[plant-scan] authenticated user=${userId}`);

  let payload: {
    mode?: string;
    image?: string;
    media_type?: string;
    note?: string;
  };
  try {
    payload = await req.json();
  } catch {
    return json({ error: "invalid_json" }, 400);
  }

  const mode = payload.mode === "diagnose" ? "diagnose" : "identify";
  const image = payload.image ?? "";
  const mediaType = payload.media_type ?? "image/jpeg";

  if (!image) {
    console.log("[plant-scan] denied: missing image in payload");
    return json({ error: "missing_image" }, 400);
  }
  if (!ALLOWED_MEDIA.includes(mediaType)) {
    return json({ error: "unsupported_media_type" }, 400);
  }
  // base64 inflates by ~4/3; check the decoded size.
  if ((image.length * 3) / 4 > MAX_IMAGE_BYTES) {
    return json({ error: "image_too_large" }, 413);
  }

  // ---- quota -------------------------------------------------------------
  const dayAgo = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString();

  const { count: todayCount } = await admin
    .from("ai_scan_usage")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", dayAgo);

  if ((todayCount ?? 0) >= DAILY_CAP) {
    return json({ error: "daily_cap_reached", limit: DAILY_CAP }, 429);
  }

  const comped = COMPED_USER_IDS.has(userId);
  const pro = comped || (await isProUser(userId));

  // Visible in the Supabase function logs. The entitlement path has several
  // ways to silently deny access  -  wrong user id in the allowlist, RevenueCat
  // keyed on a different id  -  and none of them are distinguishable from the
  // app, which just shows a paywall either way.
  console.log(
    `[plant-scan] user=${userId} comped=${comped} pro=${pro} mode=${mode}`,
  );

  if (!pro) {
    if (FREE_SCAN_LIMIT === 0) {
      return json({ error: "free_limit_reached", used: 0, limit: 0 }, 402);
    }
    const { count: lifetime } = await admin
      .from("ai_scan_usage")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId);
    if ((lifetime ?? 0) >= FREE_SCAN_LIMIT) {
      return json(
        {
          error: "free_limit_reached",
          used: lifetime ?? 0,
          limit: FREE_SCAN_LIMIT,
        },
        402,
      );
    }
  }

  // ---- the model call ----------------------------------------------------
  const anthropic = new Anthropic({
    apiKey: Deno.env.get("ANTHROPIC_API_KEY")!,
  });

  const isDiagnose = mode === "diagnose";
  const userNote = (payload.note ?? "").toString().slice(0, 400).trim();

  try {
    const response = await anthropic.messages.create({
      model: MODEL,
      max_tokens: 4000,
      system: isDiagnose ? DIAGNOSE_PROMPT : IDENTIFY_PROMPT,
      // Effort is deliberately below the default: this is a latency-sensitive
      // mobile path and the task is bounded. Raise it if answers get thin.
      output_config: {
        effort: "medium",
        format: {
          type: "json_schema",
          schema: isDiagnose ? DIAGNOSE_SCHEMA : IDENTIFY_SCHEMA,
        },
      },
      messages: [
        {
          role: "user",
          content: [
            {
              type: "image",
              source: { type: "base64", media_type: mediaType, data: image },
            },
            {
              type: "text",
              text: userNote
                ? `${isDiagnose ? "What is wrong with this plant?" : "What plant is this?"}\n\nThe grower adds: ${userNote}`
                : isDiagnose
                  ? "What is wrong with this plant?"
                  : "What plant is this?",
            },
          ],
        },
      ],
    });

    if (response.stop_reason === "refusal") {
      return json({ error: "refused" }, 422);
    }

    const textBlock = response.content.find((b) => b.type === "text");
    if (!textBlock || textBlock.type !== "text") {
      return json({ error: "empty_response" }, 502);
    }
    const result = JSON.parse(textBlock.text);

    // Record usage only after a successful scan, so a failure doesn't burn
    // someone's free allowance.
    await admin.from("ai_scan_usage").insert({
      user_id: userId,
      mode,
      input_tokens: response.usage?.input_tokens ?? null,
      output_tokens: response.usage?.output_tokens ?? null,
    });

    const { count: usedAfter } = await admin
      .from("ai_scan_usage")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId);

    return json({
      mode,
      result,
      is_pro: pro,
      scans_used: usedAfter ?? 0,
      free_limit: FREE_SCAN_LIMIT,
    });
  } catch (err) {
    console.error("plant-scan failed", err);
    const status = (err as { status?: number })?.status;
    if (status === 429) return json({ error: "busy" }, 503);
    return json({ error: "scan_failed" }, 502);
  }
});
