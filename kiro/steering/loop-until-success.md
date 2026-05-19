---
inclusion: always
---

<!-- 2026-05-19 -->

# Loop Until Success

Run a review loop on recently completed operations:

1. Dispatch **independent reviewer sub-agent** (never self-review)
2. Reviewer checks Acceptance Criteria from the Executor Prompt (PASS/FAIL per item)
3. CHANGES_REQUESTED → dispatch executor to fix → re-review
4. Max 3 rounds. APPROVED → output summary + write audit log
5. Same issue appears 2x → stop and ask user

## Reviewer Verification Standard

Reviewer receives:
- Original prompt's Acceptance Criteria (check each one)
- Produced artifacts (modified files / diff)
- Project conventions (steering files, FILE_MAP.md)

Reviewer does NOT receive:
- Executor's reasoning or chain-of-thought
- Number of attempts/iterations
- Executor's self-assessment

## Reference

Prompt format defined in `subagent-workflow.md` → Executor Prompt Template.
Design principles from [Anthropic Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
