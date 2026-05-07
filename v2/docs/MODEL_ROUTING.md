<!-- 2026-05-07 -->
# Model Routing Guide

> Per-agent model selection is available today. Use expensive models for planning, cheap models for lookup.

---

## Overview

Not every task needs the most powerful model. Route tasks to the right tier:

| Tier | Role | Model | Use For |
|------|------|-------|---------|
| Tier 1 — Premium | Planner/Orchestrator | `claude-opus-4-6` | Architecture, complex reasoning, code review |
| Tier 2 — Standard | Executor/Implementer | `claude-sonnet-4-5` | Implementation, refactoring, testing |
| Tier 3 — Economy | Explorer/Lookup | `claude-haiku-4-5` | File search, simple transforms, documentation lookup |

---

## Claude Code Setup

### Per-subagent model (frontmatter)

Create agent definitions in `.claude/agents/`:

```markdown
---
model: claude-haiku-4-5
---
# Explorer Agent
You are a lookup agent. Find files, search code, return results.
```

### Environment variable (team-wide default)

```bash
# All subagents default to Sonnet
export CLAUDE_CODE_SUBAGENT_MODEL="claude-sonnet-4-5"
```

### Resolution order

1. Explicit `model` field in agent frontmatter (highest priority)
2. `CLAUDE_CODE_SUBAGENT_MODEL` environment variable
3. Parent session's model (fallback)

### Session-level model selection

```bash
# Start session on Opus for planning
claude --model claude-opus-4-6

# Interactive switch
/model sonnet
```

---

## Kiro Setup

### Agent definition (`.kiro/agents/*.md`)

```yaml
---
name: quick-lookup
description: Fast file discovery and simple lookups
model: claude-haiku-4-5
tools:
  - Read
  - Grep
  - Glob
---
# Quick Lookup Agent
Find files and return relevant content. Do not modify anything.
```

### Current limitation

The `model` field works in **Kiro CLI** today. In the **Kiro IDE**, custom agent model fields are not yet enforced (see [Issue #6637](https://github.com/kirodotdev/Kiro/issues/6637)). The IDE uses its Auto router or the model selected in the UI.

### Kiro Auto mode

Kiro's "Auto" mode is an intelligent router that combines multiple frontier models and auto-selects per task. It delivers strong results at optimized cost without manual configuration.

---

## Cost Comparison

Approximate pricing (check current rates — these change):

| Tier | Model | Input ($/1M tokens) | Output ($/1M tokens) | Relative Cost |
|------|-------|---------------------|----------------------|---------------|
| Tier 1 | `claude-opus-4-6` | ~$15 | ~$75 | 1× (baseline) |
| Tier 2 | `claude-sonnet-4-5` | ~$3 | ~$15 | ~5× cheaper |
| Tier 3 | `claude-haiku-4-5` | ~$0.80 | ~$4 | ~15× cheaper |

**Impact:** A lookup task on Haiku costs ~15× less than the same task on Opus. Route aggressively.

---

## Automation

### Claude Code `-p` flag (non-interactive)

```bash
# Run a task headlessly with a specific model
claude -p "refactor auth module to use JWT" --model claude-sonnet-4-5

# Pipe output for CI/CD
claude -p "review this PR for security issues" --model claude-opus-4-6 --print
```

### Routines (scheduled/webhook)

Claude Code supports scheduled and event-driven routines:

- **Scheduled**: Run tasks on a cron (minimum interval: 1 hour)
- **Webhook**: Trigger via HTTP endpoint with bearer token auth
- **Headless**: Runs without terminal session

```bash
# Example: nightly code audit
claude routine create --schedule "0 2 * * *" \
  --model claude-haiku-4-5 \
  --prompt "Scan for TODO comments and security issues, write report to audit_log.md"
```

---

## Model Version Management

### Claude Code users

Model IDs in this kit use short aliases (e.g., `claude-opus-4-6`). These are **variables you update** when new models release.

**Future:** The Freshness Agent (see FUTURE_ROADMAP.md) will auto-detect new model versions and propose updates to your configuration files.

### Kiro users

Model IDs are defined as variables in `templates/MODEL_POLICY.template.md`. When a new model releases:

1. Check the [Anthropic model page](https://docs.anthropic.com/en/docs/about-claude/models) for latest IDs
2. Update the model aliases in your `MODEL_POLICY.md`
3. Update any `.kiro/agents/*.md` files that reference specific models

---

## Recommended Architecture

```
┌─────────────────────────────────────────┐
│  Orchestrator (Opus)                     │
│  Plans, delegates, reviews               │
├──────────┬──────────┬───────────────────┤
│          │          │                    │
▼          ▼          ▼                    ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│Executor│ │Executor│ │Executor│ │Explorer│
│(Sonnet)│ │(Sonnet)│ │(Sonnet)│ │(Haiku) │
│Implement│ │Test    │ │Refactor│ │Search  │
└────────┘ └────────┘ └────────┘ └────────┘
```

---

## Related

- [templates/agents/](../templates/agents/) — Ready-to-use agent definitions
- [templates/MODEL_POLICY.template.md](../templates/MODEL_POLICY.template.md) — Model governance template
- [FUTURE_ROADMAP.md](../FUTURE_ROADMAP.md) — Freshness Agent plans
