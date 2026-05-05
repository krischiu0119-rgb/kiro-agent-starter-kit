<!-- 2026-05-05 -->

# Deployment Verification Rules

> For the cross-platform source of truth, see `AGENTS.md` → Deployment Verification section.

## Core Lesson

**Git push ≠ deployed. Deployed ≠ visible to users.**

Three things can silently break the deploy pipeline:
1. Platform webhook disconnected → push doesn't trigger build
2. Build fails on platform (different env from local) → old version stays live
3. Service Worker / CDN caches old assets → user sees stale content even after successful deploy

## After Every Git Push

Run these checks in order. Stop and fix if any step fails.

### Step 1: Confirm platform received the push

Wait 15-30 seconds after push, then verify a new deployment was triggered.

**Vercel:**
```bash
vercel ls
# Look for a new deployment with age < 1 minute
# If none → run: vercel --prod --yes
```

**AWS Amplify:**
```bash
aws amplify list-jobs --app-id [APP_ID] --branch-name main --max-items 1
# Check status is RUNNING or SUCCEED
```

**Railway:**
```bash
railway status
# Or check Railway dashboard for active deployment
```

**Netlify:**
```bash
netlify status
# Or: netlify deploy --prod
```

**GitHub Pages / Actions:**
```bash
gh run list --limit 1
# Check the latest workflow run status
```

If no new deployment appears → the webhook/integration is broken. Deploy manually using your platform's CLI.

### Step 2: Confirm deployment succeeded

Check that the build completed without errors:

**Vercel:**
```bash
vercel ls
# Status must be ● Ready, not ● Error
# If Error → run: vercel logs [DEPLOYMENT_URL]
```

**AWS / Railway / Netlify:**
Check your platform's dashboard or CLI for build logs if the status shows failure.

### Step 3: Confirm live site serves new code

Use curl or a browser automation tool to verify a known change is visible:

```bash
# Example: check a version indicator, build hash, or known content
curl -s [PRODUCTION_URL]/[VERIFICATION_PATH] | head -10
```

Verification strategies:
- Check a build timestamp or version number in HTML/JS
- Verify a specific text change you just deployed
- Check response headers for deployment ID (some platforms include this)

If the content is stale → likely a caching issue (see below).

## Service Worker Cache Busting (If using PWA/Service Worker)

If your app uses a Service Worker, it may cache old assets aggressively. Use a version constant that gets bumped on deploy:

```js
const CACHE_VERSION = 'YYYYMMDD-N';  // increment N for same-day deploys
```

### When to bump CACHE_VERSION:
- Any change to page components / views
- Any change to business logic modules
- Any change to data files served to the client
- NOT needed for: docs, temporary scripts, config-only changes, server-side-only code

### Recommended caching strategy:
| Resource | Strategy | Why |
|----------|----------|-----|
| JS/CSS bundles | Network-first | Must update on deploy |
| Static images/fonts | Cache-first | Rarely change |
| Page navigations (HTML) | Network-first | Must be fresh |
| API routes | Network-only | Real-time data |

## CDN Cache Invalidation (If using CDN)

If your platform uses a CDN (CloudFront, Fastly, Cloudflare):
- Most platforms auto-invalidate on deploy, but verify
- Manual invalidation: use your CDN's purge/invalidate API
- Check `Cache-Control` headers on responses to understand TTLs

## Quick Reference Template

```bash
# Full deploy verification (customize for your project)
cd [PROJECT_DIR]
[BUILD_COMMAND]                                    # Local build check
git add -A && git commit -m "..."                  # Commit
git push                                           # Push
sleep 20                                           # Wait for platform
[PLATFORM_CHECK_COMMAND]                           # Verify deployment triggered
# If no new deployment:
[MANUAL_DEPLOY_COMMAND]                            # Manual deploy fallback
# After deployment succeeds:
curl -s [PRODUCTION_URL]/[VERIFICATION_PATH]       # Verify live content
```

## Enforcement

Claude Code has no post-push hooks. Enforcement is via:
1. This rule file (loaded automatically into context)
2. Sub-agents doing `git push` must also follow this checklist
3. Self-discipline — never assume success without verification

---

## Customization

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[PRODUCTION_URL]` | Your live site URL | `https://myapp.vercel.app` |
| `[PROJECT_DIR]` | Project root directory | `./`, `app/`, `frontend/` |
| `[BUILD_COMMAND]` | Local build command | `npm run build`, `yarn build` |
| `[PLATFORM_CHECK_COMMAND]` | CLI to check deploy status | `vercel ls`, `netlify status` |
| `[MANUAL_DEPLOY_COMMAND]` | Fallback manual deploy | `vercel --prod --yes` |
| `[VERIFICATION_PATH]` | Path to check for freshness | `sw.js`, `build-info.json` |
| `[APP_ID]` | Platform-specific app identifier | Amplify app ID |

Additional customization:
- **Platform choice**: Remove platform examples that don't apply to your project
- **Service Worker**: Remove the SW section if not using a PWA
- **CDN**: Add specific invalidation commands for your CDN provider
