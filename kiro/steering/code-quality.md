---
description: Code quality rules for AI-assisted development — modularity, testing, compound engineering.
inclusion: fileMatch
fileMatchPattern: ["**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
---

<!-- 2026-05-20 -->

# Code Quality

## Architecture
- Single Responsibility per file. Over 500 lines → review if it should be split.
- Before starting a new feature, output file structure plan (which files, responsibilities, dependencies). Confirm before coding.
- No God Objects: if a file mixes 3+ unrelated domains, it must be split.

## Testing
- New features must have basic tests (at least happy path + one edge case).
- Bug fixes must add a test to prevent recurrence.

## Compound Engineering
- Every mistake or unexpected behavior → add a new rule to this file.
- Format: `- [Context] must [behavior]. (Source: [date] [what went wrong])`

## Design Depth
- When encountering a bug or requirement change, use 5 Why to find root cause before fixing.
- Fixing the same problem a 2nd time → stop and analyze full scope, don't just patch.

## Precision
- Instructions must be specific. ❌ "write clean code" → ✅ "variables use camelCase, React components use PascalCase"
- Rules must be verifiable. ❌ "be careful about security" → ✅ "API routes must validate request body schema"

## Accumulated Rules
<!-- Format: - [Context] must [behavior]. (Source: [date] [what went wrong]) -->

- [File writing] must use `fs_write` or `fs_append` tools directly for all file creation/modification. NEVER fall back to Python scripts or bash redirection for file writing unless `fs_write` fails twice AND the root cause is diagnosed. (Source: 2026-05-20, sub-agent wrote HTML via 6 Python scripts instead of `fs_write`, wasting multiple tool calls and hitting UnicodeEncodeError)
- [Stuck detection] must dispatch a Peer Reviewer Agent before escalating to the user. Escalation path is always: Executor → Peer Reviewer → Main Agent → User. Never skip levels. (Source: 2026-05-20, sub-agent went directly to workarounds without consulting a peer reviewer, and main agent asked user before exhausting agent-level resolution)

## Sync Reminder
- When this file gets new Accumulated Rules, agent should proactively ask: "Should this rule also go to dotpilot (generic) or stay project-specific?"
