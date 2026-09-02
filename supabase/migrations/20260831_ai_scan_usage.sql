-- Usage ledger for the AI plant scanner.
--
-- One row per successful scan. Used for two things:
--   * the free-scan allowance before Pro is required
--   * a per-user daily cap, so a looping client can't run up the API bill
--
-- Only the edge function (service role) writes here. Users may read their own
-- rows so the app can show "3 of 5 free scans used" without a round trip.
--
-- Additive only: creates one new table, one index, and one read policy.
-- Nothing here drops, alters, or deletes existing data.

create table if not exists public.ai_scan_usage (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users (id) on delete cascade,
  mode          text not null check (mode in ('identify', 'diagnose')),
  input_tokens  integer,
  output_tokens integer,
  created_at    timestamptz not null default now()
);

-- The two quota queries are (user_id) and (user_id, created_at >= ...).
create index if not exists ai_scan_usage_user_created_idx
  on public.ai_scan_usage (user_id, created_at desc);

alter table public.ai_scan_usage enable row level security;

-- Read-only for the owner. Created conditionally rather than with
-- "drop policy if exists" so re-running this script stays additive.
--
-- Note there is deliberately no insert/update/delete policy: with RLS on and
-- no write policy, the anon and authenticated roles cannot write to this table
-- at all. Only the edge function's service-role key can. That is what stops
-- someone deleting their own rows to reset their free scans.
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename  = 'ai_scan_usage'
      and policyname = 'own scan usage is readable'
  ) then
    create policy "own scan usage is readable"
      on public.ai_scan_usage
      for select
      using (auth.uid() = user_id);
  end if;
end
$$;
