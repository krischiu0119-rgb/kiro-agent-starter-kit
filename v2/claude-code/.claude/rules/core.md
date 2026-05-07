<!-- 2026-05-07 -->
# Core Rules

## Response Discipline
- Every tool call → text response. Never end silently.
- Never chain 5+ tool calls without a status update.
- If stuck after 2 attempts: stop, explain blocker, try different approach.

## Task Routing
| Size | Criteria | Action |
|------|----------|--------|
| Small | ≤2 files, <20 lines | Do directly |
| Medium | 2-4 files | Ask user preference |
| Large | 4+ files or 100+ lines | Delegate + review |

## Sub-Agent Rules
- Max 3 parallel. Split 10 tasks → batches of 3.
- Pack: relevant files, acceptance criteria, `[BUILD_COMMAND]` verification.
- Include: "Check FILE_MAP.md before creating files."
- Agents must not assume files exist — verify first.
- No overlapping file edits between parallel agents.

## QA Layers
| Layer | Trigger | Action |
|-------|---------|--------|
| Smoke | Each agent done | Run `[BUILD_COMMAND]` |
| Regression | Before push | Run `[TEST_COMMAND]` |
| Full Audit | Stage milestone | Dispatch QA agents |
| Deploy | After push | Verify live site |

## Code Execution
- Complex code → file in `[TEMP_DIR]/YYYYMMDD-desc.ext`, then run.
- Simple (ls, cat, grep, version) → inline OK.

## Audit Log
Write to `audit_log.md` after: batch complete, DB migrations, file deletions, security changes.
Format: `| YYYY-MM-DD HH:MM | summary | files | reason |`

## Research Rule
Before recommending libraries/patterns: research best practices, name reference products, compare 2-3 approaches, cite sources. If user's idea differs from best practice, explain tradeoff.

## Git Safety
- Prefer feature branches; never commit directly to main without reason.
- Never force-push without explicit user approval.
- Run `[BUILD_COMMAND]` + `[TEST_COMMAND]` before push.
- Commit messages: concise, imperative, descriptive.
- Destructive git ops (reset --hard, branch -D, rebase published) require approval.

## Database Safety Reminder
Before SQL/migration work: ensure database-safety rules are loaded (Kiro: activate manual steering; Claude Code: rules are in this file).

### DB Rules (inline for Claude Code)
- Additive only: ADD COLUMN IF NOT EXISTS, CREATE INDEX IF NOT EXISTS.
- Forbidden without approval: DROP TABLE, DROP COLUMN, TRUNCATE, DELETE without WHERE.
- Before NOT NULL: fill NULLs first. Before UNIQUE: verify no duplicates.
- Migrations: idempotent, date-prefixed, in `[MIGRATIONS_DIR]`.
- New columns: DEFAULT or nullable.

## Deployment Verification
`git push` ≠ deployed. After every push:
1. Confirm platform triggered new deployment (wait 20s).
2. Confirm build succeeded (no errors in dashboard/CLI).
3. Confirm live site serves new code (curl or browser check).
If no deployment → deploy manually. If PWA/SW → bump CACHE_VERSION.

## SCAFFOLD/FLAG Rule
If implementation requires external setup: (1) check if an available MCP can handle it, (2) check .env for credentials to act directly, (3) only if neither works: scaffold code, add TODO with setup instructions, flag in completion message.

## Intelligent Guidance
If the user mentions token costs, slow responses, or budget concerns: proactively analyze their current configuration, suggest specific optimizations (model tier changes, hook disabling, conditional loading), and present pros/cons for each option.

## Exceptions (direct work OK)
- Editing config/steering/docs
- Trivial one-line changes user asks for
- Planning artifacts
- Diagnostic commands
