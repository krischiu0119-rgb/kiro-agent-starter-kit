---
description: Standard format for sub-agent executor prompts. Ensures reviewer verifiability.
inclusion: manual
---

<!-- 2026-05-19 -->

# Executor Prompt Template

Every Executor sub-agent prompt MUST follow this 3-section structure.
Designed for cross-project portability and reviewer verifiability.

## Template

```markdown
# {Ticket ID}: {One-line description}

## Task
{User-facing problem/expectation, 2-3 sentences}

### Acceptance Criteria
1. {Verifiable condition — Reviewer checks PASS/FAIL}
2. ...

## Context
- {Relevant functions, types, existing patterns}
- {Files to read/modify}
- {Reference UI patterns or existing implementations}

## Constraints
- {Things not to break}
- {Edge cases and boundary conditions}
- {Verification method: build command}
- {Language/style requirements}
```

## Design Principles

From [Anthropic: Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents):

- **Goldilocks zone**: Not overly specific (brittle if-else), not overly vague (assumes shared context)
- **Minimal high-signal tokens**: Only include what executor needs, not background stories
- **Self-contained**: Executor should not need to ask main agent for clarification
- **Reviewer-friendly**: Acceptance Criteria is the ONLY verification basis for reviewers

## Reviewer Verification Rules

- Check Acceptance Criteria line by line (each one PASS/FAIL)
- If patterns in Context are violated → CHANGES_REQUESTED
- If prohibitions in Constraints are triggered → CHANGES_REQUESTED
- If files outside Context are modified → requires explanation

## References

- [Anthropic: Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — core principles
- [PubNub: Best Practices for Claude Code Subagents](https://pubnub.com/blog/best-practices-for-claude-code-sub-agents) — 3-agent pipeline (PM→Architect→Implementer)
- [Piebald-AI/claude-code-system-prompts](https://github.com/Piebald-AI/claude-code-system-prompts) — Claude Code internal prompt structure

When unsure about prompt structure, revisit these sources to recalibrate.
