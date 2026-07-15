# Sailing Log (Working Title)

A self-contained web logbook for sailing trips. Upload a GPX track and get a
nautical map, per-leg stats (distance, duration, voyage vs harbour speed),
anchorage detection, voyage playback, photos and notes, a maintenance log, and
a buyer-facing brochure. Trips are grouped into multi-day **voyages** to build a
year-over-year catalogue.

The whole app is a single file: `index.html` (vanilla JS + Leaflet + GSAP +
Three.js, all loaded from CDN). No build step.

---

## Status / roadmap

- **Phase 1 (now): Git + Vercel.** Deploy the current app to a public URL.
  Data is still stored per-browser (IndexedDB, with a localStorage fallback), so
  it lives on whichever device you open it on.
- **Phase 2 (next): Supabase.** Move trips, voyages, maintenance and photos to a
  shared cloud database + storage, add a login (shared password first, real user
  accounts later), and a public read-only brochure link for buyers.

---

## Phase 1 — put it online

### 1. Version control (Git + GitHub)

Run these in a terminal, inside this folder:

```bash
git init
git add .
git commit -m "Initial commit: sailing log app"
```

Create an empty repo on GitHub (no README/licence, to avoid conflicts):
<https://github.com/new> — name it e.g. `sailing-log`. Then connect and push
(replace YOUR-USERNAME):

```bash
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/sailing-log.git
git push -u origin main
```

### 2. Deploy (Vercel)

1. Go to <https://vercel.com/new> and sign in with GitHub.
2. Import the `sailing-log` repository.
3. Framework preset: **Other**. Build command: **none**. Output directory:
   leave as the repo root (`./`). It's a static site, so no configuration is
   needed.
4. Click **Deploy**. You'll get a live URL like
   `https://sailing-log.vercel.app`.

Every `git push` to `main` afterwards redeploys automatically.

---

## Phase 2 — shared data (Supabase) — preview

When we're ready, this is the shape of it:

- A Supabase project provides a Postgres database + file storage + auth.
- Tables: `boats`, `voyages`, `legs` (the daily tracks), `maintenance`.
- A storage bucket holds photos.
- The app's storage layer (currently IndexedDB/localStorage) is swapped for the
  Supabase JS client. Keys go in Vercel environment variables — never committed.
- Access starts as a single shared password, then upgrades to per-user accounts.

The SQL schema and integration will be added under `supabase/` in Phase 2.

---

## Local development

Because browsers block some features on `file://`, run a tiny local server
instead of double-clicking the file:

```bash
# any one of these, from this folder:
npx serve .
# or
python -m http.server 8000
```

Then open the printed `http://localhost:...` URL.
