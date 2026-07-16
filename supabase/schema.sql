-- ============================================================
--  Sailing Log — Supabase schema (Phase 2)
--  Run this in your Supabase project: SQL Editor → New query → paste → Run.
--  Safe to run more than once.
-- ============================================================

-- Each table mirrors one part of the app. The full record lives in a JSONB
-- "doc" column so the app's existing data shapes (points, photos, notes,
-- voyageId, etc.) carry over unchanged. Access is locked to logged-in users
-- via row-level security; the public anon key alone cannot read or write.

-- ---------- tables ----------
create table if not exists boats (
  id  text primary key,          -- always 'profile'
  doc jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists voyages (
  id  text primary key,
  doc jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists legs (
  id  text primary key,
  doc jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists maintenance (
  id  text primary key,
  doc jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists meta (
  k   text primary key,
  doc jsonb,
  updated_at timestamptz not null default now()
);

-- ---------- row-level security ----------
alter table boats       enable row level security;
alter table voyages     enable row level security;
alter table legs        enable row level security;
alter table maintenance enable row level security;
alter table meta        enable row level security;

-- logged-in users get full access; anonymous visitors get nothing.
do $$
declare t text;
begin
  foreach t in array array['boats','voyages','legs','maintenance','meta'] loop
    execute format('drop policy if exists "auth all" on %I;', t);
    execute format(
      'create policy "auth all" on %I for all to authenticated using (true) with check (true);', t);
  end loop;
end $$;

-- ============================================================
--  After running this:
--  1. Authentication → Users → Add user:
--       Email:  crew@sailinglog.app   (this exact address; it is the shared login)
--       Password: choose the shared password you and your sister will use
--       Enable "Auto Confirm User" so it works immediately.
--  2. Project Settings → API: copy the "Project URL" and the "anon public" key
--     into the CONFIG block at the top of index.html.
-- ============================================================
