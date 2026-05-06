<!-- 2026-05-06 -->
# AGENTS.md — [PROJECT_NAME]

> Cross-platform agent workflow definition. Works with Kiro IDE, Claude Code, Claude CoWork.

## Project Context

- **Project**: [PROJECT_NAME]
- **Stack**: [TECH_STACK]
- **Build**: `npm run build`
- **Test**: `npm test`
- **Deploy**: `git push` → [DEPLOY_PLATFORM]

---

## Core Workflow Rules

### 1. Main Context = Planning Only

The main conversation is for **planning and coordination only**.
All implementation work is delegated to sub-agents.

Never write more than 20 lines of code in the main context.

### 2. Task Size Routing

| Size | Criteria | Action |
|------|----------|--------|
| **Small** | < 20 lines, single file | Execute directly in main context |
| **Medium** | 20-100 lines, 1-3 files | Delegate to 1 Executor sub-agent |
| **Large** | > 100 lines or 4+ files | Split into multiple Executors + Reviewer |

### 3. Parallel Agent Limits

- **Max parallel agents**: 3 (adjust based on machine RAM)
- Each agent must complete and report before spawning replacements
- Never exceed the limit — queue tasks if needed

### 4. Verification Rule

Every sub-agent **must** run the build command and confirm success before reporting done.
No exceptions. A task is not complete until the build passes.

---

## Agent Roles

### Planner
- Reads the request, breaks it into discrete tasks
- Assigns tasks to Executor agents with clear scope
- Does NOT write implementation code

### Executor
- Receives a focused task (1 feature, 1 fix, 1 migration)
- Implements the change
- Runs build/test to verify
- Reports result to `temporary/` as a markdown file

### Reviewer
- Reads Executor output from `temporary/`
- Runs QA checks (see QA Strategy below)
- Reports issues or approves

---

## QA Strategy — 3 Layers

| Layer | Trigger | Checks |
|-------|---------|--------|
| **Layer 1: Smoke** | After each sub-agent task | Build passes, no type errors, page loads |
| **Layer 2: Regression** | After feature complete | Full test suite, existing features unbroken |
| **Layer 3: Full Audit** | Before deploy / batch end | Edge cases, mobile, a11y, security, performance |

---

## File Placement

Before creating ANY new file:
1. Read `FILE_MAP.md`
2. Determine correct directory
3. Check for existing files with similar purpose
4. Only then create the file

Violations will be caught by hooks and blocked.

---

## Communication Protocol

- Sub-agents write results to `temporary/YYYYMMDD-{task-name}.md`
- Reviewer reads from `temporary/` to assess quality
- Main context reads summaries, never raw implementation details
- Clean up temporary files after batch is complete

---

## Response Discipline

- Every tool call must be followed by a text response explaining what happened
- Never chain 5+ tool calls without a status update
- If stuck after 2 attempts, stop and explain the blocker

---

## Best Practice Research

Before recommending any library, pattern, or architecture:
- Research current best practices (don't rely on training data alone)
- Check if the project already uses something similar
- Prefer what's already in the project over introducing new dependencies

---

## Audit Log

- Write to `audit_log.md` after completing a batch of work (not per-file)
- Format: `## YYYY-MM-DD — [Summary]` followed by bullet points
- Include: what changed, what was tested, what to watch

---

## Database Safety

- All migrations are **additive only** (ADD COLUMN, CREATE TABLE)
- Never DROP, TRUNCATE, or DELETE without explicit user approval
- Migration scripts go to `temporary/` with date prefix for review first
- Production data is never used for testing

---

## Deployment Verification

`git push` does NOT mean deployed. After every deploy:
1. Check platform dashboard (Vercel/AWS/Railway) for build status
2. Hit the live URL — confirm it responds correctly
3. If rollback detected, alert immediately
4. Never assume success — always verify

---

*Planning → Main context | Building → Executors | Checking → Reviewer | Logs → audit_log.md | Temp → temporary/YYYYMMDD-\*.md | Files → FILE_MAP.md*
