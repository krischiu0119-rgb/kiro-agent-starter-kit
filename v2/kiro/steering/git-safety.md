---
# 2026-05-07
description: Git safety rules — branch hygiene, pre-push checks, destructive op approval.
inclusion: auto
---

<!-- 2026-05-07 -->

# Git Safety

## Branch Rules
- Prefer feature branches; avoid committing directly to main.
- Never force-push without explicit user approval.

## Commit Hygiene
- Messages: concise, imperative, descriptive.
- Stage specific files; avoid `git add .` unless intentional.

## Pre-Push Checks
- Run `[BUILD_COMMAND]` + `[TEST_COMMAND]` before push.
- Verify no secrets in staged files (.env, credentials, keys).

## Destructive Operations (require approval)
- `git reset --hard`, `git branch -D`, `git rebase` on published branches, `git push --force`.
