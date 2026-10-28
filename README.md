# MNMN Store

A small rewards store with a shared point balance across devices and PIN-approved balance changes.

## Production
- Website: https://mnmnstore.vercel.app
- Live shared-state API: Cloudflare Worker `mnmnstore-points-api`
- Database: Cloudflare D1 `mnmnstore-shared-points`

## Source
`index.html` is the frontend. The site uses the Worker API for point changes and PIN verification. Keep PINs and recovery words on the server: never commit them to this repository.

The original website was deployed manually. This repository is being prepared for Git-connected deployments.

## Security
Do not store approval PINs, recovery words, or deployment tokens in the frontend, repository, or commit history.
