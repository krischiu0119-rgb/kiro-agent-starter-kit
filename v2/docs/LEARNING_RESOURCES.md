<!-- 2026-05-07 -->
# Learning Resources

> Build expertise in AI-assisted development. From fundamentals to champion-level mastery.

---

## Fundamentals

Before becoming effective with AI agents, build grounding in these areas:

| Fundamental | Why It Matters | Kit Connection |
|-------------|---------------|----------------|
| **Prompt Engineering** | Clear instructions → better agent output | Writing `AGENTS.md`, steering files |
| **Agent Architecture** | Understanding orchestrators, executors, reviewers | `templates/agents/`, workflow rules |
| **MCP Protocol** | How agents connect to external tools | `docs/MCP_GUIDE.md`, `mcp.template.json` |
| **Token Economics** | Why file size matters, how context windows work | `docs/TOKEN_BUDGET.md`, the entire v2 restructure |

---

## Recommended Courses

| Course | Provider | What You Learn | Kit Section |
|--------|----------|----------------|-------------|
| **Claude 101** | Anthropic Learning Program | Prompting, capabilities, limitations | `AGENTS.md`, steering file authoring |
| **Claude Code 101** | Anthropic Learning Program | CLI, sub-agents, permissions, automation | `claude-code/` folder, automation templates |
| **Introduction to Co-work** | Anthropic Learning Program | Planning, delegation, review workflows | Workflow rules, QA strategy, task routing |
| **Introduction to Skills and Agents** | Anthropic Learning Program | Custom agents, skills, agent composition | `templates/agents/`, hooks, steering files |

---

## The "Champion" Concept

A **Champion** is a power user who maintains the team's AI configuration and trains others.

### Champion responsibilities

- Maintain the team's `AGENTS.md` and steering files
- Run monthly sync checks (compare agent rules vs. human docs)
- Onboard new team members to the starter kit
- Evaluate new MCP servers and model routing strategies
- Report patterns and improvements back to the community

### How to grow Champions

1. Complete the 4 courses above
2. Customize the starter kit for a real project (hands-on practice)
3. Teach one other person (teaching solidifies understanding)
4. Contribute improvements back (propose rule changes, new templates)

---

## Agent-Suggested Learning

When the agent detects repeated failures or confusion on a topic, it can reference this file to suggest relevant learning. The mapping below connects common stuck points to resources:

### When stuck on: Database operations
- **Course**: Claude Code 101 — Database Operations module
- **Kit reference**: `docs/CUSTOMIZATION_GUIDE.md` § Database Safety
- **Root cause**: Usually unclear migration rules or missing approval patterns

### When stuck on: Agent delegation / sub-agents
- **Course**: Introduction to Co-work — Delegation Patterns
- **Kit reference**: `.kiro/steering/workflow.md` or `.claude/rules/core.md`
- **Root cause**: Usually task sizing confusion or unclear acceptance criteria

### When stuck on: Model selection / cost
- **Course**: Claude 101 — Token Economics
- **Kit reference**: `docs/MODEL_ROUTING.md`
- **Root cause**: Usually wrong tier for the task, or model field not taking effect

### When stuck on: MCP configuration
- **Course**: Introduction to Skills and Agents — Tool Integration
- **Kit reference**: `docs/MCP_GUIDE.md`
- **Root cause**: Usually missing API keys, wrong auto-approve settings, or disabled servers

### When stuck on: Token budget / slow responses
- **Course**: Claude 101 — Context Windows
- **Kit reference**: `docs/TOKEN_BUDGET.md`
- **Root cause**: Usually verbose rules, too many MCPs enabled, or playwright snapshots

### When stuck on: File placement / project structure
- **Course**: Introduction to Co-work — Project Organization
- **Kit reference**: `FILE_MAP.md` in your project
- **Root cause**: Usually missing or outdated FILE_MAP, or agents not checking it

---

## Course → Kit Section Mapping

| Course | Directly Applies To |
|--------|-------------------|
| Claude 101 | `AGENTS.md`, all steering files, `TOKEN_BUDGET.md` |
| Claude Code 101 | `claude-code/` folder, `templates/automation/`, `MODEL_ROUTING.md` |
| Introduction to Co-work | Workflow rules, QA layers, task routing tables |
| Introduction to Skills and Agents | `templates/agents/`, `.kiro/hooks/`, `MCP_GUIDE.md` |

---

## Self-Assessment

You're ready to be a Champion when you can:

- [ ] Explain why `AGENTS.md` is kept under 500 tokens
- [ ] Configure model routing for a 3-tier agent architecture
- [ ] Add a new MCP server and set appropriate auto-approve rules
- [ ] Write a new steering file that stays under 300 tokens
- [ ] Diagnose why an agent is running slowly (token budget analysis)
- [ ] Set up Claude Code automation for CI/CD review
- [ ] Train a colleague on the starter kit in under 30 minutes
