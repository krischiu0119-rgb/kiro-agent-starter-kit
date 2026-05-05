---
# 2026-05-05
description: Delegates all implementation to sub-agents, keeping the main chat for planning only.
inclusion: auto
---

<!-- 2026-05-05 -->

# Sub-Agent Development Workflow

## Response Discipline

**Every tool call MUST be followed by a text response.** Never end a turn silently after a tool returns.

- Tool returns a number (e.g., grep count = 0) → report: "0 matches, done."
- Tool returns success → report: "Completed successfully."
- Tool returns an error → report the error and next steps.

This applies to BOTH the main agent and sub-agents. The user cannot see tool output directly — they only see your text. A turn that ends without text looks like a hang/crash.

## Core Principle

The main chat context is reserved for **planning and discussion** with the user. Implementation work follows a size-based routing rule:

### Task Size Routing
- **Small** (< 2 minutes, ≤ 2 files, ≤ 30 lines changed): Do it directly in main context. No sub-agent overhead.
- **Medium** (2-5 minutes, 2-4 files): **ASK the user**: "This task can be done directly (faster) or via sub-agent + reviewer (more rigorous). Which do you prefer?" Let the user decide.
- **Large** (> 5 minutes, 4+ files, or 100+ lines): Always delegate to sub-agent(s) + reviewer. Split into parallel batches of 2-3.

The goal is **fastest total completion time**, not rigid process adherence. But when in doubt, **ask the user** rather than deciding alone.

## Workflow

1. **Plan in main context**: Discuss requirements, clarify scope, break down tasks with the user.
2. **Route by size**: Small tasks → do directly. Large tasks → delegate to sub-agents.
3. **For sub-agent tasks**: Pack context (see below) and invoke. Max 2-3 parallel.
4. **No new chat windows**: Always use `invokeSubAgent`, never suggest the user open a separate chat.

## How to Pack Context for Sub-Agents

When invoking a sub-agent, always include:

- **contextFiles**: All relevant source files the sub-agent needs to read or modify. Include line ranges if only a section matters.
- **prompt**: A clear, self-contained task description that includes:
  - What to build/fix/change
  - Key decisions already made in the planning discussion
  - Constraints (libraries, patterns, naming conventions)
  - Acceptance criteria (what "done" looks like)
  - Which QA/build commands to run for verification
- **name**: Use `general-task-execution` for implementation tasks, `context-gatherer` for investigation.

## Parallel Execution

If a plan has independent tasks, dispatch multiple sub-agents in the same turn.

### Resource Limits (IMPORTANT)
- **Max 3-4 agents in parallel** — more than this risks crashing the IDE due to memory pressure
- **Max 5 contextFiles per agent** — each file is loaded into memory; large files (500+ lines) count double
- **Avoid overlapping file edits** — two agents editing the same file will cause conflicts
- **Split large batches** — if you have 10 tasks, run them in 3 batches of 3-4, not all at once

### Agent Quality Rules
- Every agent prompt MUST include: what to do, acceptance criteria, and `[BUILD_COMMAND]` verification
- Agents MUST NOT assume files exist — if unsure, use tools to check first
- Agents MUST NOT guess severity levels — only report what they can verify in code
- If an agent needs to check whether a file/directory exists, instruct it to use `listDirectory` or `readFile` first

## After Sub-Agent Returns

- Briefly summarize what was done (1-3 sentences) in the main context.
- If the sub-agent reports issues, discuss with the user before dispatching a fix.
- Do NOT re-read or re-verify files that the sub-agent already confirmed — trust its output.

## QA Strategy (3-Layer)

QA is NOT a per-edit hook. It runs at three levels with different frequencies.

### Layer 1: Smoke Test (every sub-agent, automatic)
- Every executor sub-agent prompt MUST end with: "Run `[BUILD_COMMAND]` to verify. Fix any errors before reporting done."
- Catches compile errors and type mismatches immediately.
- Cost: ~30 seconds, zero extra memory.
- Frequency: every sub-agent completion.

### Layer 2: Regression Test (every development batch, main agent runs directly)
- After ALL sub-agents in a batch complete, the main agent runs `[TEST_COMMAND]` directly in terminal.
- Confirms old features are not broken by new changes.
- Cost: ~5-10 seconds, no sub-agent needed.
- Frequency: once per batch (e.g., after "P0 fixes done", before git push).
- Also run before every `git push` / deploy.
- Note: Create a project-specific test runner script if one doesn't exist.

### Layer 3: Full QA Audit (per-Stage, uses sub-agents)
- Triggered manually by user, OR after a Stage milestone is complete.
- Dispatches 2-3 QA sub-agents (NOT more — memory pressure) to review:
  - New features built since last Full QA
  - Integration points between new and existing features
  - Data integrity checks
  - Security/compliance spot-checks
- Then dispatches 1 Reviewer sub-agent to cross-check QA results.
- Cost: significant (20-30 min, memory-intensive). Only run when needed.
- Frequency: once per Stage completion, or when user explicitly requests.

### When to trigger each layer:
| Trigger | Layer 1 | Layer 2 | Layer 3 |
|---------|---------|---------|---------|
| Sub-agent finishes a task | ✅ | | |
| All sub-agents in batch done | | ✅ | |
| Before git push / deploy | | ✅ | |
| Stage milestone complete | | ✅ | ✅ |
| User explicitly asks for QA | | ✅ | ✅ |
| Every file edit | ❌ | ❌ | ❌ |

### Layer 4: Deploy Verification (every git push)
- After `git push`, verify deployment succeeded (see `deployment-verification.md` steering if present)
- If using a Service Worker / PWA, bump cache version when app code changes
- Sub-agents doing git push must also follow this

## File Placement Rules (Template)

Every sub-agent prompt that creates new files MUST include:

> **Before creating any new file**, check `FILE_MAP.md` for placement rules.

Then list your project's specific rules in your FILE_MAP.md. Example structure:

```
- Type definitions → [TYPES_FILE]
- Data access functions → [DATA_LAYER_FILE]
- Utility functions → [UTILS_FILE]
- New pages/routes → [PAGES_DIR]/{feature}/
- Shared UI components → [COMPONENTS_DIR]/
- Temporary/migration scripts → [TEMP_DIR]/YYYYMMDD-description.{ext}
```

If your project doesn't have a FILE_MAP.md yet, create one with your conventions.

## Exceptions

You MAY work directly in the main context for:
- Editing steering files, hooks, or project docs (README, TODO, etc.)
- Trivial one-line config changes the user explicitly asks for "right here"
- Planning artifacts (writing specs, task breakdowns)
- Running diagnostic commands to answer a question

## Audit Log

The main agent maintains the audit log manually (hook-based audit logging is too heavy — spawns an agent context on every write).

### When to write audit entries:
- After completing a development batch (before git push)
- After database migrations
- After deleting or archiving files
- After changing security-related code (auth, access control, API keys)

### Format:
Append to `audit_log.md`:
```
| YYYY-MM-DD HH:MM | batch-summary | files affected | what changed and why |
```

Keep entries concise (1 line per batch, not per file). The git commit history has the detailed diff.

## Best Practice Reference

When the user asks for advice, proposes a feature, or requests a design decision:
1. **Always research industry best practices** before answering — use web search if needed
2. **Name specific reference products** (e.g., "Stripe does X", "Shopify handles this by Y")
3. **Compare 2-3 approaches** with pros/cons before recommending one
4. **Cite sources** when referencing standards (security standards, accessibility guidelines, regulations)
5. If the user's idea differs from best practice, explain the tradeoff honestly — don't just agree

---

## Customization

Replace these placeholders with your project-specific values:

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[BUILD_COMMAND]` | Your project's build/compile command | `npm run build`, `cargo build`, `go build ./...` |
| `[TEST_COMMAND]` | Your project's test runner | `npm test`, `pytest`, `go test ./...` |
| `FILE_MAP.md` | Path to your file placement rules | Create at project root or in docs/ |

Additional customization:
- **Task Size Routing**: Adjust the "Medium" prompt to match your team's language
- **QA Layer 2**: Create a regression test script specific to your project
- **QA Layer 3**: Define what "data integrity" means for your domain
- **Audit Log**: Adjust the log file path if needed (default: `audit_log.md` at workspace root)
- **File Placement Rules**: Fill in your project's actual directory conventions
