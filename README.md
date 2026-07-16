# Sailing Log

A web logbook for sailing trips. Upload a GPX track and get a nautical map,
per-leg stats (distance, duration, voyage vs harbour speed), anchorage
detection, voyage playback, photos and notes, a maintenance log, and a
buyer-facing brochure. Legs are grouped into multi-day **voyages** to build a
year-over-year catalogue.

The whole app is one file — `index.html` — vanilla JS + Leaflet + GSAP +
Three.js + the Supabase client, all from CDNs. No build step.

- **Live:** https://sailing-log.vercel.app
- **Repo:** https://github.com/Amdisen/sailing-log
- **Data:** Supabase (Postgres + Auth). Login required.

---

## Start here next time (local preview)

1. Double-click **`start-dev.bat`** (or in a terminal: `npx -y serve -l 8000`).
2. Open **http://localhost:8000** and log in.
3. Edit `index.html`, then hard-refresh the browser (Ctrl+Shift+R) to see changes.

Tip: keep the server in its own terminal window and use a **second** terminal
for git — running `git` in the server's window stops the preview.
If port 8000 is busy: `npx -y serve -l 8001`.

## Ship changes (deploy)

From a terminal in this folder:

```powershell
git add -A
git commit -m "what changed"
git push
```

Vercel auto-deploys `main` in ~20s. Check https://sailing-log.vercel.app.

---

## Project layout

- `index.html` — the entire app (UI, map, logic, Supabase data layer, auth).
- `supabase/schema.sql` — database tables + row-level security. Run once in the
  Supabase SQL editor; safe to re-run.
- `vercel.json` — static hosting config.
- `start-dev.bat` — local preview launcher.

## Architecture

- **Git → GitHub → Vercel:** every push to `main` redeploys the static site.
- **Supabase:** Postgres tables `boats`, `voyages`, `legs`, `maintenance`,
  `meta` (each stores a JSON `doc`), plus Auth. The app's storage layer talks to
  these via the Supabase JS client. The publishable key + URL are in `index.html`
  (safe to expose — row-level security + login protect the data).

## Managing users (admin)

No public sign-up. Add crew in Supabase → **Authentication → Users → Add user →
Create new user**: their email + a password + tick **Auto Confirm User**. Give
them that email/password; they log in on the site.
(An invite-by-email flow exists in the app but needs custom SMTP to send —
skipped for now; see roadmap.)

Auth email links (invites/resets) use **Authentication → URL Configuration →
Site URL** = `https://sailing-log.vercel.app`.

---

## Status

Done:
- Phase 1: Git + GitHub + Vercel (live, auto-deploy).
- Phase 2: Supabase cloud storage + email/password login (+ invite/reset flow
  in-app, pending SMTP).
- Core app: GPX upload/parse, speed-coloured track, anchorage detection,
  voyage playback, hover tooltips, per-leg details (engine hours, crew, weather,
  notes, photos), boat profile, maintenance log, buyer brochure with print/PDF.
- Voyages layer: catalogue tab + grouped list, drag-and-drop legs between
  voyages (sidebar and catalogue).
- Design: consistent design system, Emil-Kowalski motion rules, Apple design
  pass (frosted materials, optical Inter typography, reduced-motion/transparency),
  full mobile responsive pass + burger menu + reworked mobile Map view.

## Roadmap / next

- Photos → Supabase Storage (keep the DB light as galleries grow).
- Public read-only brochure link per voyage (share with buyers, no login).
- Invite-by-email: connect custom SMTP (e.g. Resend) so invites/resets send.
- Mobile Map polish: tap-to-collapse info sheet; layer control as a single icon.
- Real per-user accounts / invite-code sign-up (currently one shared logbook for
  all logged-in users).

## Notes / gotchas

- Map tiles, fonts, and libraries load from CDNs, so the app needs internet.
- The five Summer 2026 GPX files were consolidated locally; re-upload them on the
  live site if the cloud logbook is empty (cloud started fresh).
