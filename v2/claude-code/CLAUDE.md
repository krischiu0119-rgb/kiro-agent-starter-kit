<!-- 2026-05-07 -->
# [PROJECT_NAME]

## WHY
Keep main context for planning. Delegate implementation to sub-agents.
Enforce quality through rules + discipline (Claude Code has no hooks).

## WHAT
- **Project**: [PROJECT_NAME]
- **Stack**: [TECH_STACK]
- **Build**: `[BUILD_COMMAND]`
- **Test**: `[TEST_COMMAND]`
- **Deploy**: `git push` → [DEPLOY_PLATFORM]

## HOW
- Main context = planning only (never write >20 lines of code here)
- Delegate implementation to sub-agents by task size
- See `AGENTS.md` for cross-platform workflow
- See `.claude/rules/core.md` for all behavioral rules

## Critical Rules

1. Every sub-agent must run `[BUILD_COMMAND]` before reporting done
2. Check `FILE_MAP.md` before creating any new file
3. Never DROP/TRUNCATE database tables without explicit user approval
4. `git push` ≠ deployed — always verify live site
5. Every tool call → text response — never end silently
6. Max 3 parallel sub-agents

## Task Size Routing

| Size | Criteria | Action |
|------|----------|--------|
| Small | < 20 lines, 1 file | Do directly |
| Medium | 20-100 lines, 1-3 files | Ask user: direct or sub-agent? |
| Large | 100+ lines or 4+ files | Always delegate + review |

## File Structure
- `FILE_MAP.md` — file placement rules
- `[TEMP_DIR]/YYYYMMDD-description.ext` — temporary files
- `audit_log.md` — batch-level change log

## QA (no hooks — enforce via discipline)
- **Layer 1**: Build passes after every sub-agent task
- **Layer 2**: Full test suite before push (`[TEST_COMMAND]`)
- **Layer 3**: Manual audit before major releases
