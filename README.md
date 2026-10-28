# MNMN Store

A personal rewards storefront with a **shared, server-side point balance** across phones.

**Live site:** https://mnmnstore.vercel.app

## Repository contents

| File | Purpose |
| --- | --- |
| `index.html` | Full frontend (HTML, CSS, JavaScript); no build required |
| `workers/points-api.js` | Cloudflare Worker handling shared state, approval PIN verification, point changes and PIN recovery |
| `db/schema.sql` | Cloudflare D1 schema; initializes the shared balance at **0 points** |

## Architecture

- Frontend: static HTML hosted on Vercel.
- Backend: `mnmnstore-points-api` Cloudflare Worker.
- Database: Cloudflare D1 `mnmnstore-shared-points`.
- Score and activity history live in the shared database, not local storage.
- The website refreshes shared state periodically while visible.
- PINs and recovery words are checked server-side against database hashes, never embedded in frontend code.

### Default score

A new D1 database initialized with `db/schema.sql` begins at **0 points** (`half_points = 0`). Existing score is held server-side; redeploying the site does not automatically reset a user's earned points. The production database was separately reset to **0** on October 29, 2026.

## Running locally

Serve the repository root with any static HTTP server, for example:

```bash
python3 -m http.server 8000
```

The page uses the production API by default. The API currently restricts allowed browser origins; localhost will need to be explicitly allowed in the Worker for local mutation testing.

## Deployment

**Current status:** Production is live on Vercel, but the existing Vercel project is **not yet linked to this GitHub repository**. A separate Cloudflare renderer is currently supplying the live HTML. The source here is an independent snapshot that can be deployed as a static site.

To enable automatic Git deployments:

1. In Vercel, authorize its GitHub integration for the **`iomarsuleiman`** GitHub account/repository (not the separately connected `omar-Suleiman14` namespace).
2. Open the existing **`mnmnstore`** Vercel project, go to **Settings → Git**, and connect `iomarsuleiman/mnmnstore`.
3. Use `main` as the production branch and serve `index.html` from the repository root.
4. Verify a preview, then switch the project to Git-built production deployments. Verify that the shared points API accepts the production domain.

Do not create an additional production domain or move aliases until the Git deployment is verified.

## Security

Never commit approval PINs, recovery words, API credentials, or unmasked hash values. Populate the `credentials` table securely outside version control. Do not expose reset secrets in the frontend or public commits.

The current backend uses a shared four-digit approval PIN, which is suitable only for a personal low-stakes store—not financial transactions or sensitive systems.
