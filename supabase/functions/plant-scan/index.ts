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
// npm: specifier rather than esm.sh — the Anthropic SDK pulls in enough Node
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
// 0 makes the scanner Pro-only, so it never costs money for a user who isn't
// paying. Raise it to reintroduce a free trial — no app release needed, this
// is server-side.
const FREE_SCAN_LIMIT = 0;

// Hard ceiling per user per day, Pro included — protects against a runaway
// client loop turning into an unbounded bill.
const DAILY_CAP = 40;

const MAX_IMAGE_BYTES = 5 * 1024 * 1024;
const ALLOWED_MEDIA = ["image/jpeg", "image/png", "image/webp"];

const IDENTIFY_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["is_plant", "common_name", "confidence", "summary", "next_steps"],
  properties: {
    is_plant: {
      type: "boolean",
      description: "False if the photo does not show a plant at all.",
    },
    common_name: {
      type: "string",
      description: "Everyday name, e.g. 'Basil'. Empty string if is_plant is false.",
    },
    scientific_name: { type: "string" },
    confidence: { type: "string", enum: ["high", "medium", "low"] },
    summary: {
      type: "string",
      description: "Two or three sentences: what it is and how to tell.",
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
    plant_guess: { type: "string" },
    problem: {
      type: "string",
      description: "Short name of what is wrong, e.g. 'Early blight'.",
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

Name the plant as a gardener would (common name first). Give the scientific name when you are reasonably sure of it.

Be honest about uncertainty. Many photos are blurry, show only a leaf, or show a seedling that could be several things. Say "low" confidence and name the most likely candidate rather than inventing false precision — a confident wrong answer sends someone to plant the wrong thing.

If the photo does not show a plant, set is_plant to false and leave the other fields empty rather than guessing.

Keep the summary to two or three plain sentences. No preamble.`;

const DIAGNOSE_PROMPT = `You diagnose plant problems from photographs for a home gardening app.

Work from what is actually visible: leaf colour and pattern, spotting, wilting, insect damage, the growing medium. Name the most likely problem and say plainly how confident you are.

Rules that matter:
- If the plant looks fine, say so — set looks_healthy true and severity "none". Do not invent a problem to seem useful.
- Many symptoms have several causes (over- and under-watering look alike). List the real candidates instead of committing to one.
- Prefer cultural fixes (watering, spacing, airflow, removing affected leaves) before chemical ones.
- If you recommend any treatment that could harm people, pets or pollinators, say so in that step.
- If the photo does not show a plant, set is_plant to false.

Keep every step short and actionable. No preamble.`;

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
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
  if (!authHeader.startsWith("Bearer ")) {
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
    return json({ error: "unauthorized" }, 401);
  }
  const userId = userData.user.id;

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

  if (!image) return json({ error: "missing_image" }, 400);
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

  const pro = await isProUser(userId);
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
