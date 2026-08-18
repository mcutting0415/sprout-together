// Supabase Edge Function: delete-account
//
// Permanently deletes the calling user's account and all their data.
// Apple App Store guideline 5.1.1(v) requires apps with account creation to
// offer in-app account deletion. A client cannot delete its own auth user, so
// this runs server-side with the service-role key.
//
// Deploy:
//   supabase functions deploy delete-account
// (SUPABASE_URL / SUPABASE_ANON_KEY / SUPABASE_SERVICE_ROLE_KEY are injected
//  automatically by the platform — no secrets to set.)

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) return json({ error: "Missing authorization header" }, 401);

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    // Identify the caller from their JWT (never trust a client-supplied id).
    const userClient = createClient(supabaseUrl, anonKey, {
      global: { headers: { Authorization: authHeader } },
    });
    const {
      data: { user },
      error: userErr,
    } = await userClient.auth.getUser();
    if (userErr || !user) return json({ error: "Invalid or expired session" }, 401);

    const uid = user.id;
    const admin = createClient(supabaseUrl, serviceKey);

    // 1. Plots are keyed by garden_id, so delete them via the user's gardens.
    const { data: gardens } = await admin
      .from("gardens")
      .select("id")
      .eq("user_id", uid);
    const gardenIds = (gardens ?? []).map((g: { id: string }) => g.id);
    if (gardenIds.length > 0) {
      await admin.from("garden_plots").delete().in("garden_id", gardenIds);
    }

    // 2. Delete the rest of the user's rows (children before parents).
    await admin.from("garden_tasks").delete().eq("user_id", uid);
    await admin.from("garden_journal_entries").delete().eq("user_id", uid);
    await admin.from("user_goals").delete().eq("user_id", uid);
    await admin.from("user_selected_plants").delete().eq("user_id", uid);
    await admin.from("gardens").delete().eq("user_id", uid);
    await admin.from("profiles").delete().eq("id", uid);

    // 3. Best-effort: remove the user's uploaded files.
    for (const bucket of ["garden-photos", "profile-photo"]) {
      for (const prefix of [uid, `journal/${uid}`]) {
        try {
          const { data: files } = await admin.storage
            .from(bucket)
            .list(prefix, { limit: 1000 });
          if (files && files.length > 0) {
            await admin.storage
              .from(bucket)
              .remove(files.map((f) => `${prefix}/${f.name}`));
          }
        } catch (_) {
          // Ignore storage cleanup errors — the account deletion below is what matters.
        }
      }
    }

    // 4. Finally, delete the auth user itself.
    const { error: delErr } = await admin.auth.admin.deleteUser(uid);
    if (delErr) return json({ error: delErr.message }, 500);

    return json({ success: true });
  } catch (e) {
    return json({ error: String(e) }, 500);
  }
});
