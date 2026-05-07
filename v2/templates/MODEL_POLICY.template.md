<!-- 2026-05-07 -->
<!-- TEMPLATE: Copy to your project root as MODEL_POLICY.md -->
<!-- Update model IDs when new versions release -->

# Model Usage Policy

> Defines which models are approved for each agent tier and usage limits.

---

## Approved Models

| Tier | Role | Model ID | Notes |
|------|------|----------|-------|
| Tier 1 — Premium | Orchestrator, Planner, Reviewer | `claude-opus-4-6` | Complex reasoning, architecture |
| Tier 2 — Standard | Implementer, Refactorer, Tester | `claude-sonnet-4-5` | Balanced quality/cost |
| Tier 3 — Economy | Explorer, Lookup, Simple transforms | `claude-haiku-4-5` | Fast, cheap, read-heavy tasks |

**Update these IDs when new models release.**

- Claude Code users: The Freshness Agent (future project) will auto-detect new versions and propose updates.
- Kiro users: Check [Anthropic models page](https://docs.anthropic.com/en/docs/about-claude/models) periodically and update manually.

---

## Routing Rules

| Task Type | Required Tier | Rationale |
|-----------|--------------|-----------|
| Architecture decisions | Tier 1 | Needs deep reasoning |
| Code review | Tier 1 | Needs nuanced judgment |
| Feature implementation | Tier 2 | Good balance of quality and speed |
| Bug fixes | Tier 2 | Needs code understanding |
| Refactoring | Tier 2 | Needs style awareness |
| File search / grep | Tier 3 | Simple pattern matching |
| Documentation lookup | Tier 3 | Read and summarize |
| Status checks | Tier 3 | Minimal reasoning needed |

---

## Budget Limits

| Scope | Daily Limit | Monthly Limit |
|-------|-------------|---------------|
| Tier 1 (Premium) | [DAILY_TIER1_LIMIT] | [MONTHLY_TIER1_LIMIT] |
| Tier 2 (Standard) | [DAILY_TIER2_LIMIT] | [MONTHLY_TIER2_LIMIT] |
| Tier 3 (Economy) | Unlimited | Unlimited |
| **Total** | [DAILY_TOTAL_LIMIT] | [MONTHLY_TOTAL_LIMIT] |

---

## Escalation Rules

- If a Tier 3 agent fails a task twice → escalate to Tier 2
- If a Tier 2 agent fails a task twice → escalate to Tier 1
- If a Tier 1 agent fails → stop and report to user
- Never escalate for cost reasons alone — escalate for capability

---

## Exceptions

- Emergency production fixes: Tier 1 approved regardless of budget
- Batch operations (>10 files): Tier 2 minimum (Tier 3 lacks context capacity)
- Security-sensitive changes: Tier 1 required for review step

---

## Version History

| Date | Change | Reason |
|------|--------|--------|
| [DATE] | Initial policy | Kit setup |
