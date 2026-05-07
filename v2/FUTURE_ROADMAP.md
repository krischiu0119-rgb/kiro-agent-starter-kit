<!-- 2026-05-07 -->
# Future Roadmap

> Enterprise vision for the Kiro Agent Starter Kit. No timelines — sized by effort only.

---

## Planned Initiatives

### 1. Freshness Agent (S)

**What:** An agent that auto-detects stale model versions, MCP server versions, and dependency versions in your configuration files. Proposes updates via PR or inline suggestion.

**Why:** Model aliases and MCP packages update regularly. Manual tracking doesn't scale across teams. Stale configs mean missed performance improvements and security patches.

**Size:** Small — single-purpose agent with version-checking logic.

**Dependencies:** Version checking APIs (Anthropic model list, npm registry, PyPI). Notification mechanism (PR, commit, or inline comment).

**Notes:**
- Claude Code users get this first (automation via `-p` flag + Routines)
- Kiro users benefit from the model ID updates in `MODEL_POLICY.template.md`

---

### 2. Agent-Suggested Learning (S)

**What:** When an agent detects it's stuck in a loop (same error 2+ times, user rephrasing 3+ times), it references `LEARNING_RESOURCES.md` and suggests relevant courses or documentation.

**Why:** Reduces frustration loops. Accelerates user skill development. Turns failure moments into learning opportunities.

**Size:** Small — detection heuristics + file lookup + suggestion formatting.

**Dependencies:** `docs/LEARNING_RESOURCES.md` (already created). Detection heuristics (pattern matching on repeated failures).

---

### 3. A/B Testing Harness (M)

**What:** Framework to test whether rule changes improve agent behavior. Same task, two rule sets, measure quality/cost/speed. Statistical comparison of outcomes.

**Why:** Currently rule changes are "ship and hope." No way to measure if a terse rule performs as well as a verbose one, or if a new routing strategy actually saves money.

**Size:** Medium — needs evaluation criteria, test runner, comparison logic.

**Dependencies:** Claude Code `-p` flag for headless execution. Evaluation criteria definition. Baseline measurements.

---

### 4. Progressive MCP Disclosure (M-L)

**What:** Instead of loading all MCP tool definitions at session start, progressively reveal tools as context requires. Agent starts with core tools, gains access to specialized tools when the task demands it.

**Why:** Each MCP server adds thousands of tokens of tool schemas before the user even asks a question. A session about database work doesn't need playwright tool definitions.

**Size:** Medium-Large — requires protocol-level support or middleware layer.

**Dependencies:** MCP protocol support for lazy loading (not yet in spec). Alternatively, a middleware/router that gates tool visibility based on task classification.

---

### 5. Librarian Agent (L)

**What:** A meta-agent that manages which MCP servers are available per project. Validates security posture of MCPs, provides usage analytics, recommends MCPs from the registry based on project needs.

**Why:** Prevents ungoverned MCP sprawl. As teams scale to 10+ MCPs, security risks and cost overruns emerge without centralized management.

**Size:** Large — needs registry integration, security scanning, analytics pipeline.

**Dependencies:** MCP Registry API (available). MetaMCP pattern for aggregation. Security scanning heuristics. Usage tracking mechanism.

---

### 6. AI Governance Layer (L)

**What:** Configuration-driven policy engine enforcing model selection rules, cost budgets, and approval workflows. Prevents agents from spawning expensive models without limits.

**Why:** Without governance, agents can escalate to Opus for trivial tasks, teams exceed budgets without visibility, and compliance gaps emerge in regulated industries.

**Size:** Large — needs policy engine, cost tracking, approval workflows, audit trails.

**Dependencies:** Model routing working in both platforms. Cost tracking API (Anthropic Console or third-party). RBAC integration for team-level policies.

---

### 7. Enterprise Skill Management (L)

**What:** System for teams to share, version, and govern reusable agent skills. Steering files + hooks + agent definitions packaged as installable units with semantic versioning.

**Why:** No way to share best practices across a team today. No way to enforce standards, roll back bad rule changes, or discover what skills other teams have built.

**Size:** Large — needs packaging format, registry, versioning, governance controls.

**Dependencies:** Kiro Powers system (existing). Git-based versioning. Team registry infrastructure. Review/approval workflow for shared skills.

**Related tools available today:**
- `skill-creator` plugin for Claude Code — lets users create custom skills
- `superpowers` plugin — provides a marketplace of pre-built skills
- These could serve as the distribution mechanism for enterprise skills

---

## Size Legend

| Size | Effort | Team |
|------|--------|------|
| S | 1-2 weeks | 1 person |
| M | 2-6 weeks | 1-2 people |
| L | 2-6 months | 2-4 people |

---

## Dependency Graph

```
Agent-Suggested Learning (S) ← LEARNING_RESOURCES.md ✅ (done)
Freshness Agent (S) ← Version APIs + Automation
A/B Testing Harness (M) ← Claude Code -p + Evaluation criteria
Progressive MCP Disclosure (M-L) ← MCP protocol changes
Librarian Agent (L) ← MCP Registry + Security scanning
AI Governance Layer (L) ← Model routing + Cost tracking
Enterprise Skill Management (L) ← Kiro Powers + Git versioning
```

---

## How to Contribute

If you're interested in building any of these:
1. Open an issue describing your approach
2. Start with the smallest viable version
3. Document token impact (everything has a budget)
4. Test with real projects before proposing as default
