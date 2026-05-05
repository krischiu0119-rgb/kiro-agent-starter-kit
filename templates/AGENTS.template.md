<!-- 2026-05-05 -->
<!-- TEMPLATE: Copy this file into your project root and rename to AGENTS.md -->
<!-- This defines how AI agents collaborate on your project. -->
<!-- Fill in the [PLACEHOLDERS], delete <!-- TEMPLATE comments when done. -->

# AGENTS.md — [PROJECT_NAME]

> Cross-platform agent workflow definition. Works with Kiro IDE, Claude Code, Claude CoWork.

---

## Project Context

<!-- TEMPLATE: Quick reference for any agent that reads this file. -->
<!-- Delete this comment after filling in. -->

- **Project**: [PROJECT_NAME]
- **Stack**: [TECH_STACK — e.g., "Next.js 14 + TypeScript + Supabase"]
- **Build**: `[BUILD_COMMAND — e.g., npm run build]`
- **Test**: `[TEST_COMMAND — e.g., npm test]`
- **Deploy**: `[DEPLOY_COMMAND]` → [DEPLOY_PLATFORM — e.g., Vercel, AWS, Railway]

---

## Core Workflow Rules

### 1. Main Context = Planning Only

<!-- TEMPLATE: This is the most important rule. The main conversation plans; -->
<!-- sub-agents execute. This keeps context clean and focused. -->
<!-- Delete this comment after reading. -->

The main conversation is for **planning and coordination only**.
All implementation work is delegated to sub-agents.

Never write more than 20 lines of code in the main context.

### 2. Task Size Routing

<!-- TEMPLATE: Adjust the thresholds to match your project's complexity. -->
<!-- A project with many small files might use lower thresholds. -->
<!-- Delete this comment after filling in. -->

| Size | Criteria | Action |
|------|----------|--------|
| **Small** | < 20 lines, single file | Execute directly in main context |
| **Medium** | 20-100 lines, 1-3 files | Delegate to 1 Executor sub-agent |
| **Large** | > 100 lines or 4+ files | Split into multiple Executors + Reviewer |

### 3. Parallel Agent Limits

<!-- TEMPLATE: Adjust based on your machine's RAM. -->
<!-- 8GB RAM → max 2 agents | 16GB → max 3 | 32GB+ → max 4-5 -->
<!-- Delete this comment after filling in. -->

- **Max parallel agents**: [NUMBER — typically 2-3]
- Each agent must complete and report before spawning replacements
- Never exceed the limit — queue tasks if needed

### 4. Verification Rule

<!-- TEMPLATE: This ensures agents don't report "done" with broken code. -->
<!-- Customize the command to your project's build/test setup. -->
<!-- Delete this comment after reading. -->

Every sub-agent **must** run `[BUILD_COMMAND]` and confirm success before reporting done.
No exceptions. A task is not complete until the build passes.

---

## Agent Roles

### Planner

<!-- TEMPLATE: The planner is YOU in the main conversation. -->
<!-- Delete this comment after reading. -->

- Reads the request, breaks it into discrete tasks
- Assigns tasks to Executor agents with clear scope
- Does NOT write implementation code

### Executor

<!-- TEMPLATE: Executors do the actual coding work. -->
<!-- Delete this comment after reading. -->

- Receives a focused task (1 feature, 1 fix, 1 migration)
- Implements the change
- Runs build/test to verify
- Reports result to `temporary/` as a markdown file

### Reviewer (optional)

<!-- TEMPLATE: Recommended for large batches of work. -->
<!-- Delete this section entirely if you don't use reviewers. -->
<!-- Delete this comment after filling in. -->

- Reads Executor output from `temporary/`
- Runs QA checks (see QA Strategy below)
- Reports issues or approves

---

## QA Strategy

<!-- TEMPLATE: Define your quality gates. Adjust layers to your needs. -->
<!-- You might only need Layer 1 for small projects. -->
<!-- Delete this comment after filling in. -->

| Layer | Trigger | Checks |
|-------|---------|--------|
| **Layer 1: Smoke** | After each sub-agent task | Build passes, no type errors |
| **Layer 2: Regression** | After feature complete | [TEST_COMMAND], existing features unbroken |
| **Layer 3: Full Audit** | Before deploy | [DESCRIBE — e.g., edge cases, mobile, a11y, security] |

<!-- TEMPLATE (OPTIONAL): If you have a custom QA script, reference it here. -->
<!-- Example: "Run `node temporary/qa-runner.mjs` for Layer 2 (33 automated checks)" -->
<!-- Delete this comment after filling in or if not applicable. -->

---

## File Placement

<!-- TEMPLATE: This prevents agents from creating files in wrong locations. -->
<!-- Delete this comment after reading. -->

Before creating ANY new file:
1. Read `FILE_MAP.md`
2. Determine correct directory
3. Check for existing files with similar purpose
4. Only then create the file

Violations will be caught by hooks and blocked.

---

## Communication Protocol

<!-- TEMPLATE: How do agents pass information to each other? -->
<!-- Since sub-agents can't talk directly, they use files as a medium. -->
<!-- Adjust the naming convention to your preference. -->
<!-- Delete this comment after filling in. -->

- Sub-agents write results to `temporary/YYYYMMDD-{task-name}.md`
- Reviewer reads from `temporary/` to assess quality
- Main context reads summaries, never raw implementation details
- Clean up temporary files after batch is complete

---

## Response Discipline

<!-- TEMPLATE: Keeps agents from going silent during long operations. -->
<!-- Delete this comment after reading. -->

- Every tool call must be followed by a text response explaining what happened
- Never chain 5+ tool calls without a status update
- If stuck after 2 attempts, stop and explain the blocker

---

## Database Safety (optional)

<!-- TEMPLATE: Delete this entire section if your project has no database. -->
<!-- Delete this comment after filling in or removing section. -->

- All migrations are **additive only** (ADD COLUMN, CREATE TABLE)
- Never DROP, TRUNCATE, or DELETE without explicit user approval
- Migration scripts go to `temporary/` with date prefix for review first
- Production data is never used for testing

---

## Deployment Verification (optional)

<!-- TEMPLATE: Delete this section if you don't auto-deploy. -->
<!-- Delete this comment after filling in or removing section. -->

`git push` does NOT mean deployed. After every deploy:
1. Check platform dashboard ([PLATFORM]) for build status
2. Hit the live URL — confirm it responds correctly
3. If rollback detected, alert immediately
4. Never assume success — always verify

---

## Audit Log (optional)

<!-- TEMPLATE: Delete this section if you don't use an audit log. -->
<!-- Delete this comment after filling in or removing section. -->

- Write to `audit_log.md` after completing a batch of work
- Format: `| Timestamp | Action | Target | Reason |`
- Include: what changed, what was tested, what to watch

---

## Custom Rules (optional)

<!-- TEMPLATE: Add any project-specific rules that don't fit above. -->
<!-- Examples: -->
<!-- "Always use the project's custom logger, never console.log" -->
<!-- "All API responses must include a `requestId` field" -->
<!-- "Never import from `@internal/` packages in public-facing code" -->
<!-- Delete this section if you have no custom rules. -->

- [CUSTOM_RULE_1]
- [CUSTOM_RULE_2]

---

<!-- TEMPLATE: This footer is a quick-reference cheat sheet. Customize it. -->
*Planning → Main context | Building → Executors | Checking → Reviewer | Logs → audit_log.md | Temp → temporary/YYYYMMDD-\*.md | Files → FILE_MAP.md*
