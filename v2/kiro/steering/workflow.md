---
# 2026-05-07
description: Delegates all implementation to sub-agents, keeping the main chat for planning only.
inclusion: auto
---

<!-- 2026-05-07 -->

# Workflow

## Response Discipline
- Every tool call → text response. Never end silently.
- Never chain 5+ tool calls without status update.
- If stuck after 2 attempts: stop, explain blocker, try different approach.

## Task Routing
| Size | Criteria | Action |
|------|----------|--------|
| Small | ≤2 files, <20 lines | Do directly |
| Medium | 2-4 files | Ask user preference |
| Large | 4+ files or 100+ lines | Delegate + review |

## Sub-Agent Rules
- Max 3 parallel. Split 10 tasks → batches of 3.
- Pack context: relevant files (max 5 per agent), acceptance criteria, `[BUILD_COMMAND]`.
- Include: "Check FILE_MAP.md before creating files."
- Agents must not assume files exist — verify first.
- No overlapping file edits between parallel agents.
- Large files (500+ lines) count double toward context limit.

## QA Layers
| Layer | Trigger | Action |
|-------|---------|--------|
| Smoke | Each agent done | Run `[BUILD_COMMAND]` |
| Regression | Before push | Run `[TEST_COMMAND]` |
| Full Audit | Stage milestone | Dispatch 2-3 QA agents + reviewer |
| Deploy | After push | Verify live site |

## Audit Log
Write to `audit_log.md` after: batch complete, DB migrations, file deletions, security changes.
Format: `| YYYY-MM-DD HH:MM | summary | files | reason |`

## Research Rule
Before recommending libraries/patterns: research best practices, name reference products, compare 2-3 approaches, cite sources. If user's idea differs, explain tradeoff.

## Database Safety Reminder
Before SQL/migration work: ensure database-safety rules are loaded (activate manual steering `database-safety.md`).

## SCAFFOLD/FLAG Rule
If implementation requires external setup: (1) check if an available MCP can handle it, (2) check .env for credentials to act directly, (3) only if neither works: scaffold code, add TODO with setup instructions, flag in completion message.

## Intelligent Guidance
If the user mentions token costs, slow responses, or budget concerns: proactively analyze their current configuration, suggest specific optimizations (model tier changes, hook disabling, conditional loading), and present pros/cons for each option.

## Exceptions (direct work OK)
- Editing config/steering/docs
- Trivial one-line changes user asks for
- Planning artifacts
- Diagnostic commands
