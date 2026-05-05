<!-- 2026-05-05 -->

# Sub-Agent Development Workflow

> Claude Code enforces this via rules + discipline. There are no automated hooks.
> For the cross-platform source of truth, see `AGENTS.md` at project root.

## Response Discipline

**Every tool call MUST be followed by a text response.** Never end a turn silently after a tool returns.

- Tool returns a number (e.g., grep count = 0) → report: "0 matches, done."
- Tool returns success → report: "Completed successfully."
- Tool returns an error → report the error and next steps.

The user cannot see tool output directly — they only see your text. A turn that ends without text looks like a hang/crash.

## Core Principle

The main chat context is reserved for **planning and discussion** with the user. Implementation work follows a size-based routing rule.

### Task Size Routing
- **Small** (< 2 minutes, ≤ 2 files, ≤ 30 lines changed): Do it directly in main context.
- **Medium** (2-5 minutes, 2-4 files): **ASK the user**: "Direct (faster) or sub-agent + reviewer (more rigorous)?"
- **Large** (> 5 minutes, 4+ files, or 100+ lines): Always delegate to sub-agents. Split into parallel batches of 2-3.

The goal is **fastest total completion time**, not rigid process adherence.

## Workflow

1. **Plan in main context**: Discuss requirements, clarify scope, break down tasks.
2. **Route by size**: Small → do directly. Large → delegate to sub-agents.
3. **For sub-agent tasks**: Pack context and dispatch. Max 2-3 parallel.
4. **Use Claude Code's native sub-agent capability** — never suggest the user open a separate chat.

## How to Pack Context for Sub-Agents

When dispatching a sub-agent, always include:

- **Relevant source files** the sub-agent needs to read or modify
- **A clear, self-contained task description** including:
  - What to build/fix/change
  - Key decisions already made in the planning discussion
  - Constraints (libraries, patterns, naming conventions)
  - Acceptance criteria (what "done" looks like)
  - Build/test commands to run for verification
- **File placement reminder**: "Check `FILE_MAP.md` before creating new files"

## Parallel Execution Limits

- **Max 3 sub-agents in parallel** — more risks crashing due to memory pressure
- **Avoid overlapping file edits** — two agents editing the same file causes conflicts
- **Split large batches** — if you have 10 tasks, run them in batches of 3, not all at once
- Every agent prompt MUST include: what to do, acceptance criteria, and `[BUILD_COMMAND]` verification
- Agents MUST NOT assume files exist — check first

## After Sub-Agent Returns

- Briefly summarize what was done (1-3 sentences) in the main context
- If the sub-agent reports issues, discuss with the user before dispatching a fix
- Do NOT re-read or re-verify files that the sub-agent already confirmed

## QA Strategy (3-Layer)

### Layer 1: Smoke Test (every sub-agent, automatic)
- Every sub-agent prompt MUST end with: "Run `[BUILD_COMMAND]` to verify. Fix any errors before reporting done."
- Frequency: every sub-agent completion.

### Layer 2: Regression Test (every batch)
- After ALL sub-agents in a batch complete, run `[TEST_COMMAND]` directly.
- Also run before every `git push` / deploy.
- Frequency: once per batch.

### Layer 3: Full QA Audit (per-Stage milestone)
- Triggered manually by user, OR after a Stage milestone is complete.
- Dispatch 2-3 QA sub-agents to review new features, integration points, data integrity, security.
- Then dispatch 1 Reviewer sub-agent to cross-check.
- Frequency: once per Stage completion.

### Layer 4: Deploy Verification (every git push)
- After `git push`, verify deployment succeeded (see `deployment-verification.md`)
- If using a Service Worker / PWA, bump cache version when app code changes

| Trigger | L1 | L2 | L3 |
|---------|----|----|-----|
| Sub-agent finishes a task | ✅ | | |
| All sub-agents in batch done | | ✅ | |
| Before git push / deploy | | ✅ | |
| Stage milestone complete | | ✅ | ✅ |
| User explicitly asks for QA | | ✅ | ✅ |

## File Placement Rules

Every sub-agent prompt that creates new files MUST include:

> **Before creating any new file**, check `FILE_MAP.md` for placement rules.

Enforcement note: Claude Code has no file-creation hooks. This rule is enforced by including it in every sub-agent prompt and by self-discipline.

## Audit Log

Write to `audit_log.md` manually (no hook automation in Claude Code):

### When to write:
- After completing a development batch (before git push)
- After database migrations
- After deleting or archiving files
- After changing security-related code

### Format:
```
| YYYY-MM-DD HH:MM | batch-summary | files affected | what changed and why |
```

Keep entries concise (1 line per batch, not per file).

## Best Practice Research

When the user asks for advice or proposes a feature:
1. **Research industry best practices** before answering — use web search if needed
2. **Name specific reference products** (e.g., "Stripe does X", "Shopify handles this by Y")
3. **Compare 2-3 approaches** with pros/cons before recommending
4. **Cite sources** when referencing standards
5. If the user's idea differs from best practice, explain the tradeoff honestly

## Exceptions

You MAY work directly in the main context for:
- Editing config files, project docs (README, TODO, etc.)
- Trivial one-line changes the user explicitly asks for
- Planning artifacts (writing specs, task breakdowns)
- Running diagnostic commands to answer a question

---

## Customization

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[BUILD_COMMAND]` | Build/compile command | `npm run build`, `cargo build` |
| `[TEST_COMMAND]` | Test runner | `npm test`, `pytest` |
| `[TEMP_DIR]` | Temporary files directory | `temporary/`, `tmp/` |
