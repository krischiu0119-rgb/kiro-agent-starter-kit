<!-- 2026-05-07 -->
# Rule Checklist — Behavioral Rules Extracted from v1

> Safety net: verify no rule is lost during v2 rewrite.

## Response Discipline
- [ ] 1. Every tool call MUST be followed by a text response — never end silently
- [ ] 2. Tool returns number → report it; success → confirm; error → report + next steps

## Task Routing
- [ ] 3. Main context = planning only; never write >20 lines of code in main context
- [ ] 4. Small (<20 lines, 1 file): do directly
- [ ] 5. Medium (20-100 lines, 1-3 files): ask user preference
- [ ] 6. Large (100+ lines or 4+ files): always delegate to sub-agents + reviewer

## Sub-Agent Rules
- [ ] 7. Max 3 parallel sub-agents (memory pressure limit)
- [ ] 8. Pack context: relevant files, self-contained prompt, acceptance criteria, build command
- [ ] 9. Include "Check FILE_MAP.md before creating new files" in every sub-agent prompt
- [ ] 10. Agents must not assume files exist — check first
- [ ] 11. Agents must not guess severity — only report what's verifiable in code
- [ ] 12. Avoid overlapping file edits between parallel agents
- [ ] 13. Split large batches (10 tasks → 3 batches of 3-4)

## QA Layers
- [ ] 14. Layer 1 (Smoke): every sub-agent runs BUILD_COMMAND before reporting done
- [ ] 15. Layer 2 (Regression): run TEST_COMMAND after batch completes, before push
- [ ] 16. Layer 3 (Full Audit): per-stage milestone, dispatch 2-3 QA agents + reviewer
- [ ] 17. Layer 4 (Deploy): verify deployment after git push

## File Placement
- [ ] 18. Check FILE_MAP.md before creating any new file
- [ ] 19. Temporary files: TEMP_DIR/YYYYMMDD-description.ext

## Code Execution
- [ ] 20. Complex code → create file in TEMP_DIR, then run
- [ ] 21. Simple commands (ls, cat, grep, version checks) → inline OK
- [ ] 22. File naming: YYYYMMDD-description.ext

## Database Safety
- [ ] 23. Never DROP TABLE without explicit user approval
- [ ] 24. Never DROP COLUMN without explicit user approval
- [ ] 25. Never TRUNCATE without explicit user approval
- [ ] 26. Never DELETE FROM without WHERE without explicit user approval
- [ ] 27. Additive only: ADD COLUMN IF NOT EXISTS, CREATE INDEX IF NOT EXISTS
- [ ] 28. Before NOT NULL: UPDATE SET default WHERE NULL first
- [ ] 29. Before UNIQUE: verify no duplicates exist
- [ ] 30. Migrations must be idempotent (IF NOT EXISTS / IF EXISTS)
- [ ] 31. New columns must have DEFAULT or be nullable
- [ ] 32. Migration files: date-prefixed in MIGRATIONS_DIR

## Deployment Verification
- [ ] 33. git push ≠ deployed — always verify
- [ ] 34. Step 1: confirm platform received push (new deployment triggered)
- [ ] 35. Step 2: confirm build succeeded (no errors)
- [ ] 36. Step 3: confirm live site serves new code (curl/check)
- [ ] 37. Service Worker: bump CACHE_VERSION when app code changes
- [ ] 38. If no deployment appears → deploy manually via CLI

## Audit Log
- [ ] 39. Write to audit_log.md after completing a batch (not per-file)
- [ ] 40. Format: | YYYY-MM-DD HH:MM | summary | files | reason |
- [ ] 41. Write after: batch complete, DB migrations, file deletions, security changes

## Best Practice Research
- [ ] 42. Research industry best practices before recommending
- [ ] 43. Name specific reference products (Stripe, Shopify, etc.)
- [ ] 44. Compare 2-3 approaches with pros/cons
- [ ] 45. Cite sources for standards
- [ ] 46. If user's idea differs from best practice, explain tradeoff honestly

## Communication
- [ ] 47. Sub-agents write results to temporary/YYYYMMDD-{task-name}.md
- [ ] 48. After sub-agent returns: summarize 1-3 sentences in main context
- [ ] 49. If sub-agent reports issues: discuss with user before dispatching fix
- [ ] 50. Do NOT re-read files sub-agent already confirmed

## Exceptions (direct work OK)
- [ ] 51. Editing config/steering/docs files
- [ ] 52. Trivial one-line changes user explicitly asks for
- [ ] 53. Planning artifacts (specs, breakdowns)
- [ ] 54. Running diagnostic commands

## Git Safety (new in v2)
- [ ] 55. Prefer feature branches over main
- [ ] 56. Never force-push without explicit approval
- [ ] 57. Commit messages: concise, descriptive
- [ ] 58. Pre-push: run build + tests

## SCAFFOLD/FLAG (new in v2)
- [ ] 59. If implementation requires external setup: (1) check MCP, (2) check .env, (3) scaffold + TODO + flag

## Intelligent Guidance (new in v2)
- [ ] 60. If user mentions token costs/slow responses/budget: proactively analyze config, suggest optimizations
