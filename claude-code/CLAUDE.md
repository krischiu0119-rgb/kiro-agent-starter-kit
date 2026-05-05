<!-- 2026-05-05 -->
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

## HOW — Workflow
- Main context = planning only (never write >20 lines of code here)
- Delegate implementation to sub-agents by task size
- See `AGENTS.md` for full cross-platform workflow definition
- See `.claude/rules/` for detailed rule files

## Critical Rules (always follow)

1. Every sub-agent must run `[BUILD_COMMAND]` before reporting done
2. Check `FILE_MAP.md` before creating any new file
3. Never DROP/TRUNCATE database tables without explicit user approval
4. `git push` ≠ deployed — always verify (see `.claude/rules/deployment-verification.md`)
5. Every tool call must be followed by a text response — never end silently
6. Max 3 parallel sub-agents — more risks memory pressure

## Task Size Routing

| Size | Criteria | Action |
|------|----------|--------|
| Small | < 20 lines, 1 file | Do directly |
| Medium | 20-100 lines, 1-3 files | Ask user: direct or sub-agent? |
| Large | 100+ lines or 4+ files | Always delegate + review |

## File Structure
- `FILE_MAP.md` — file placement rules (read before creating files)
- `[TEMP_DIR]/YYYYMMDD-description.ext` — temporary/scratch files
- `audit_log.md` — batch-level change log

## QA (no hooks — enforce via discipline)
- **Layer 1**: Build passes after every sub-agent task
- **Layer 2**: Full test suite before push (`[TEST_COMMAND]`)
- **Layer 3**: Manual audit before major releases

## References
- `AGENTS.md` — Cross-platform workflow (source of truth)
- `FILE_MAP.md` — File placement rules
- `.claude/rules/workflow.md` — Sub-agent workflow details
- `.claude/rules/database-safety.md` — Migration safety
- `.claude/rules/deployment-verification.md` — Deploy checklist
- `.claude/rules/code-execution-practices.md` — Code file rules
