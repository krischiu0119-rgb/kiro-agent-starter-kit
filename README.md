<!-- 2026-05-19 -->
# Kris's AI Starter Kit

> A progressive framework for structured AI-assisted development — from beginner to fully autonomous.

A drop-in framework for structured AI-assisted development using sub-agents (Planner/Executor/Reviewer pattern), 3-layer QA, and automated housekeeping. Works with **Kiro IDE**, **Claude Code**, and **Claude CoWork**.

> **Formerly "Claude Cowork Starter Kit"** — renamed because this kit works across all AI coding tools, not just CoWork.

---

## 🧭 Before You Start: Explore the Ecosystem

Even if you don't use this kit, these repos offer excellent alternative approaches:

| Repo | Stars | Focus | Best For |
|------|-------|-------|----------|
| [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) | 47k+ | From vibe coding to agentic engineering | Comprehensive CLAUDE.md patterns |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 14.8k+ | Curated commands, files, workflows | Discovery & reference |
| [SuperClaude-Org/SuperClaude_Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework) | — | Cognitive personas + specialized commands | Power users who want slash commands |
| [anthropics/skills](https://github.com/anthropics/skills) | Official | Anthropic's public Agent Skills | Official skill patterns |
| [josix/awesome-claude-md](https://github.com/josix/awesome-claude-md) | — | Exemplary CLAUDE.md files from real projects | Learning by example |
| [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) | — | Lightweight meta-prompting + spec-driven dev | Minimalists |
| [mksglu/context-mode](https://github.com/mksglu/context-mode) | — | Saves 98% context window via FTS5 indexing | Token-constrained users |

### Related: Private Configuration Repo

For the author's personal (de-identified) steering files, hooks, and accumulated learnings:
→ [krischiu0119-rgb/dotpilot](https://github.com/krischiu0119-rgb/dotpilot)

---

## 🎯 Who Is This For?

Teams using **Kiro IDE**, **Claude Code**, or **Claude CoWork** who want:
- Consistent agent behavior across multiple projects
- Structured delegation (no more 500-line single-agent chaos)
- Automated quality gates that catch issues before deploy
- A shared workflow that works regardless of which AI tool team members prefer

### Budget Considerations

| Your Plan | Monthly Budget | Recommended Approach |
|-----------|---------------|---------------------|
| Free / Pro | $20-50 | Phase 1 only. Human-in-the-loop. Context Mode essential. |
| Team | $50-100 | Phase 1-2. Selective sub-agents. |
| Enterprise / Max | $100+ | Full Phase 1-3. Autonomous agents OK. |
| Unlimited (Kiro/internal) | No limit | Everything enabled from Day 1. |

---

## 📦 Recommended Plugins & Skills

Install these progressively based on your comfort level and budget:

### Day 1 — Essential (saves tokens, zero risk)

```bash
# Context Mode — reduces context consumption by up to 98%
/plugin marketplace add mksglu/context-mode
/plugin install context-mode@context-mode
```

### Week 2-3 — Core Skills (moderate token cost)

```bash
# Superpowers — TDD, debugging, brainstorming, subagent dev + code review
/plugin install superpowers@claude-plugins-official

# Get Shit Done — lightweight spec-driven development
npx get-shit-done-cc --claude --global
```

### Week 4+ — Advanced (higher token cost, for experienced users)

```bash
# Skill Creator — teach Claude to auto-create new skills
/plugin install skill-creator@claude-plugins-official

# Claude Mem — cross-session memory
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

# Frontend Design — frontend-specific patterns (alternative to Open Design)
/plugin install frontend-design@claude-plugins-official
```

### Design System Options

| System | Best For | Control Level |
|--------|----------|---------------|
| **Open Design** (default) | HTML reports, decks, one-pagers, landing pages | Full (you own the tokens) |
| **Frontend Design Plugin** | React/Vue component development | Anthropic-managed |

Both can coexist. Use Open Design for documents, Frontend Design for app UI.

---

## 🚀 Progressive Learning Path

**Don't enable everything on Day 1.** Follow this path:

### Phase 1: Observer Mode (Week 1-2) — YOU are the Orchestrator

```
You: Break tasks yourself, write prompts yourself
Agent: Only executes single tasks (Executor role)
You: Review all results personally

Goal: Understand agent capabilities and limitations
Token cost: Low (~$5-15/week)
```

**What to do:**
- Use plan mode before coding
- Give specific, scoped prompts (one file, one feature)
- Read every line the agent produces
- Correct mistakes immediately — learn what confuses it

### Phase 2: Co-Pilot Mode (Week 3-4) — Shared responsibility

```
You: High-level direction + final review
Agent: Plans + executes + self-checks (Executor + Self-Challenge)
You: Only intervene on quality issues

Goal: Build trust in agent's self-checking ability
Token cost: Medium (~$15-40/week)
```

**What to do:**
- Enable Executor Self-Challenge
- Let agent propose plans (but you approve before execution)
- Start using sub-agents for research/investigation
- Install Superpowers for structured development patterns

### Phase 3: Delegation Mode (Week 5+) — Agent-driven

```
You: Strategic decisions only
Agent: Full Planner → Executor → Reviewer pipeline
You: Only engage on ESCALATE_TO_USER

Goal: Fully autonomous development with safety rails
Token cost: High (~$40-100+/week)
```

**What to do:**
- Enable full sub-agent architecture
- Enable /goal or loop patterns (if your tool supports it)
- Trust the Reviewer to catch issues
- Focus on architecture and product decisions

---

## 5-Minute Setup

### Option A: Claude Code Users (Easiest — paste one prompt)

Copy the entire prompt below and paste it into your Claude Code conversation. It will set everything up automatically:

```
I want to adopt an AI agent workflow framework into this project.

Please fetch the framework content from this GitHub repo:
https://github.com/krischiu0119-rgb/ai-starter-kit

Then execute these steps:

1. Use fetch or GitHub API to read all files in the repo's claude-code/ folder
2. Write claude-code/CLAUDE.md to my project root as CLAUDE.md
3. Write all .md files from claude-code/.claude/rules/ to my project's .claude/rules/ directory
4. Read AGENTS.md from the repo root and write it to my project root
5. Analyze my current project structure, then:
   - Generate a FILE_MAP.md (documenting each important file's location and purpose)
   - Generate a PROJECT_BRIEF.md (project summary so sub-agents can quickly understand the project)
6. Replace all [PLACEHOLDER] values (like [BUILD_COMMAND], [PROJECT_NAME], etc.) in AGENTS.md and CLAUDE.md with my project's actual values
7. Create a temporary/ folder (if it doesn't exist)
8. Create an audit_log.md (if it doesn't exist)

When done, give me a summary: what you did, which files were changed, and how to start using the framework.
```

**That's it!** Claude will complete all setup automatically.

---

### Option B: Kiro IDE Users (Same simplicity)

Paste this prompt into Kiro's chat:

```
I want to adopt an AI agent workflow framework.

Please fetch the framework content from this GitHub repo:
https://github.com/krischiu0119-rgb/ai-starter-kit

Then execute these steps:

1. Use fetch or GitHub API to read all files in the repo's kiro/ folder
2. Write all .md files from kiro/steering/ to my project's .kiro/steering/ directory
3. Write all .kiro.hook files from kiro/hooks/ to my project's .kiro/hooks/ directory
4. Read AGENTS.md from the repo root and write it to my project root
5. Analyze my current project structure, then:
   - Generate a FILE_MAP.md (documenting each important file's location and purpose)
   - Generate a PROJECT_BRIEF.md (project summary so sub-agents can quickly understand the project)
6. Replace all [PLACEHOLDER] values with my project's actual values
7. Create a temporary/ folder (if it doesn't exist)
8. Create an audit_log.md (if it doesn't exist)

When done, give me a summary: what you did, which files were changed, and how to start using the framework.
```

---

### Option C: Manual Installation (For full control)

```bash
# 1. Clone this repo
git clone https://github.com/krischiu0119-rgb/ai-starter-kit.git

# 2. Navigate to your project directory
cd your-project

# 3a. If you use Claude Code:
cp ../ai-starter-kit/claude-code/CLAUDE.md .
cp -r ../ai-starter-kit/claude-code/.claude/ .
cp ../ai-starter-kit/AGENTS.md .

# 3b. If you use Kiro IDE:
cp -r ../ai-starter-kit/kiro/ .kiro/
cp ../ai-starter-kit/AGENTS.md .

# 4. Edit AGENTS.md — replace all [PLACEHOLDER] values with your project info
# 5. Create FILE_MAP.md (see templates/FILE_MAP.template.md for reference)
# 6. Start using it!
```

---

## How to Use After Setup

Once setup is complete, start every new work session by telling the agent:

```
Read AGENTS.md and understand the workflow. Today's task is: [your task here]
```

The agent will automatically adopt the **Planner → Executor → Reviewer** workflow:
- Large tasks get broken into small chunks and processed in parallel
- Each sub-task runs a build verification before reporting done
- Files are never created in the wrong place (agents check FILE_MAP.md first)
- Deployments are verified after every push

---

## 🔍 Resource Priority (for Agent behavior)

When the agent looks for solutions, it follows this order:

1. **LOCAL**: This project's own files (steering/, skills/, AGENTS.md)
2. **STARTER KIT**: Patterns from this repo
3. **CURATED**: Repos listed in the ecosystem table above
4. **OFFICIAL DOCS**: Anthropic, framework docs
5. **WEB SEARCH**: Only as last resort

This ensures consistent behavior and avoids the agent recommending random internet solutions when a tested pattern already exists.

---

## Quick Reference

| I am... | What should I do? |
|---------|-------------------|
| **Claude Code user** | Copy the Option A prompt, paste into your conversation |
| **Kiro IDE user** | Copy the Option B prompt, paste into your conversation |
| **Manual setup preferred** | Follow Option C steps |
| **Want to learn more** | Read [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) |
| **Want to see examples** | Check the [examples/](./examples/) folder |
| **Looking for the private version** | See [dotpilot](https://github.com/krischiu0119-rgb/dotpilot) |

## Directory Structure

```
ai-starter-kit/
├── AGENTS.md                  # Cross-platform source of truth (shared by all tools)
├── MIGRATION_GUIDE.md         # Adoption guide for existing projects
├── README.md                  # You are here
│
├── kiro/                      # For Kiro IDE users → copy to .kiro/
│   ├── steering/
│   │   ├── subagent-workflow.md
│   │   ├── database-safety.md
│   │   ├── deployment-verification.md
│   │   └── code-execution-practices.md
│   └── hooks/
│       ├── audit-log-writer.kiro.hook
│       ├── housekeeping.kiro.hook
│       ├── qa-full-audit.kiro.hook
│       ├── qa-post-edit.kiro.hook
│       └── verify-deploy.kiro.hook
│
├── claude-code/               # For Claude Code users → copy to project root
│   ├── CLAUDE.md
│   └── .claude/
│       └── rules/
│           ├── workflow.md
│           ├── database-safety.md
│           ├── deployment-verification.md
│           └── code-execution-practices.md
│
├── templates/                 # Blank templates to fill in
│   ├── AGENTS.template.md
│   ├── FILE_MAP.template.md
│   ├── PROJECT_BRIEF.template.md
│   └── audit_log.template.md
│
└── examples/                  # Filled-in examples for reference
    └── minimal-project/       # Python FastAPI REST API example
```

## Key Concepts

### Sub-Agent Workflow

The main context is for **planning only**. All implementation is delegated to sub-agents:

| Role | Responsibility |
|------|---------------|
| **Planner** | Breaks tasks into steps, assigns to executors |
| **Executor** | Implements one focused task, verifies with build |
| **Reviewer** | Checks output quality, runs QA layers |

### 3-Layer QA Strategy

| Layer | When | What |
|-------|------|------|
| **Smoke** | After every sub-agent task | Build passes, no type errors, basic functionality |
| **Regression** | After feature complete | Run full test suite, check existing features unbroken |
| **Full Audit** | Before deploy / end of batch | Deep check: edge cases, mobile, accessibility, security |

### Adaptive Stopping (Convergence Rules)

The review loop doesn't run forever:
- **Default cap**: 5 iterations
- **Early exit**: Reviewer approves → stop immediately
- **Behavioral guardrails**: After iteration 2, agent cannot delete/recreate modules, change DB schema as a "fix", or install new dependencies
- **Escalate to user**: Same issue found twice, agent stalls, or agent attempts destructive action

### Housekeeping Agent

Runs periodically (or on manual trigger) to:
- Update `audit_log.md` with batch summaries
- Clean up `temporary/` files older than 7 days
- Verify `FILE_MAP.md` matches actual project structure
- Flag TODOs that have been open > 2 weeks

### File Placement Rules

Before creating any new file, agents **must** check `FILE_MAP.md` to determine the correct location. No guessing, no "I'll put it here for now."

### Database Safety

- Migrations are **additive only** — never DROP columns/tables without explicit approval
- All migrations go through `temporary/` first for review
- Production data is sacred — never modify without backup

### Deployment Verification

`git push` ≠ deployed. After every deploy:
1. Check deployment platform status (Vercel/AWS/Railway)
2. Hit the live URL and verify response
3. Confirm no rollback occurred

## Customization

When adopting this kit, customize these for your project:

| What to Change | Where | Example |
|---------------|-------|---------|
| Build command | AGENTS.md, steering files | `npm run build` → `pnpm build` |
| Test command | QA steering files | `npm test` → `pytest` |
| File structure | FILE_MAP_TEMPLATE.md | Add your app's directories |
| Deploy target | deployment-verification | Vercel → AWS CDK |
| Tech stack | AGENTS.md header | Next.js → Django + HTMX |
| Max parallel agents | AGENTS.md | 3 → 5 (if 32GB+ RAM) |

## Resource Limits

Default configuration assumes:
- **3 parallel sub-agents** (suitable for 16GB RAM machines)
- Adjust in AGENTS.md if your machine has more/less capacity
- Each sub-agent holds ~8K tokens of context

| RAM | Recommended Max Agents |
|-----|----------------------|
| 8GB | 1-2 |
| 16GB | 3 (default) |
| 32GB+ | 4-5 |

## Compatibility

| Tool | Support Level | Notes |
|------|--------------|-------|
| **Kiro IDE** | ✅ Full | Steering files + hooks |
| **Claude Code** | ✅ Full | CLAUDE.md + .claude/rules/ + skills + plugins |
| **Claude CoWork** | ✅ Full | Uses AGENTS.md directly |
| **Cursor** | ⚠️ Partial | AGENTS.md works, no hooks |
| **Windsurf** | ⚠️ Partial | AGENTS.md works, no hooks |

## Contributing

This is a living framework. Every time an agent makes a mistake:
1. Identify the root cause
2. Add a rule to prevent recurrence
3. Update AGENTS.md or the relevant steering file

Good rules come from real mistakes.

## License

MIT
