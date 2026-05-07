<!-- 2026-05-07 -->
# AGENTS.md — [PROJECT_NAME]

> Cross-platform agent rules. Works with Kiro IDE, Claude Code, Claude CoWork.

## Project

- **Name**: [PROJECT_NAME]
- **Stack**: [TECH_STACK]
- **Build**: `[BUILD_COMMAND]`
- **Test**: `[TEST_COMMAND]`
- **Deploy**: `git push` → [DEPLOY_PLATFORM]

## Workflow

Main context = planning only. Delegate implementation to sub-agents.

| Size | Criteria | Action |
|------|----------|--------|
| Small | ≤2 files, <20 lines | Do directly |
| Medium | 2-4 files, 20-100 lines | Ask user preference |
| Large | 4+ files or 100+ lines | Delegate + review |

## Rules

1. Every sub-agent runs `[BUILD_COMMAND]` before reporting done
2. Check `FILE_MAP.md` before creating any file
3. Max 3 parallel sub-agents
4. Every tool call → text response (never end silently)
5. `git push` ≠ deployed — verify live site
6. Never DROP/TRUNCATE without explicit approval
7. Audit log: write after batch, not per-file

## QA Layers

| Layer | Trigger | What |
|-------|---------|------|
| Smoke | Each sub-agent | Build passes |
| Regression | Before push | Full test suite |
| Full Audit | Stage milestone | Edge cases, security, a11y |
| Deploy | After push | Verify live site |

## Agent Roles

- **Planner**: breaks tasks, assigns scope — no implementation
- **Executor**: implements, verifies build, reports result
- **Reviewer**: cross-checks quality, reports issues

## File Conventions

- `FILE_MAP.md` — placement rules
- `[TEMP_DIR]/YYYYMMDD-description.ext` — scratch files
- `audit_log.md` — batch change log
