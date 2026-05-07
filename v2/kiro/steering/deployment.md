---
# 2026-05-07
description: Deployment verification checklist — never assume git push = live. Always confirm.
inclusion: manual
---

<!-- 2026-05-07 -->

# Deployment Verification

## Core Rule
`git push` ≠ deployed. Deployed ≠ visible to users.

## 3-Step Verification (after every push)

1. **Platform received push** — wait 20s, check for new deployment in dashboard/CLI.
2. **Build succeeded** — status is Ready/Success, not Error.
3. **Live site serves new code** — curl or browser check for expected content.

## Failure Modes
- Webhook disconnected → push doesn't trigger build. Fix: deploy manually via CLI.
- Build fails on platform → old version stays live. Fix: check build logs.
- CDN/SW caches stale assets → user sees old content. Fix: invalidate cache or bump version.

## PWA/Service Worker Note
If app uses SW: bump `CACHE_VERSION` constant when app code changes. Not needed for docs-only or server-side-only changes.
