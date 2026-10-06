-- Daybook database setup. Paste into Supabase -> SQL Editor -> New query, then Run.

create table if not exists public.daybook_docs (
  user_id    uuid        not null default auth.uid() references auth.users (id) on delete cascade,
  path       text        not null,   -- "days/2026-10-06" or "meta/state"
  data       jsonb       not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, path)
);

-- Only the signed-in owner can see or change their own rows.
alter table public.daybook_docs enable row level security;
revoke all on public.daybook_docs from anon;

drop policy if exists "read own"   on public.daybook_docs;
drop policy if exists "insert own" on public.daybook_docs;
drop policy if exists "update own" on public.daybook_docs;
drop policy if exists "delete own" on public.daybook_docs;
create policy "read own"   on public.daybook_docs for select to authenticated using (auth.uid() = user_id);
create policy "insert own" on public.daybook_docs for insert to authenticated with check (auth.uid() = user_id);
create policy "update own" on public.daybook_docs for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "delete own" on public.daybook_docs for delete to authenticated using (auth.uid() = user_id);

-- Live sync between your devices.
alter publication supabase_realtime add table public.daybook_docs;
