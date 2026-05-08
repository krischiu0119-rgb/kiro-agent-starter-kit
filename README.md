<!-- 2026-05-06 -->
# AI Agent Workflow Starter Kit

> A reusable framework for structured AI-assisted development

A drop-in framework for structured AI-assisted development using sub-agents (Planner/Executor/Reviewer pattern), 3-layer QA, and automated housekeeping. Add it to any project and get consistent, reliable agent behavior from day one.

## Who Is This For?

Teams using **Kiro IDE** or **Claude Code** who want:
- Consistent agent behavior across multiple projects
- Structured delegation (no more 500-line single-agent chaos)
- Automated quality gates that catch issues before deploy
- A shared workflow that works regardless of which AI tool team members prefer

---

## 5-Minute Setup

### Option A: Claude Code Users (Easiest — paste one prompt)

Copy the entire prompt below and paste it into your Claude Code conversation. It will set everything up automatically:

```
I want to adopt an AI agent workflow framework into this project.

Please fetch the framework content from this GitHub repo:
https://github.com/krischiu0119-rgb/kiro-agent-starter-kit

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
https://github.com/krischiu0119-rgb/kiro-agent-starter-kit

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
git clone https://github.com/krischiu0119-rgb/kiro-agent-starter-kit.git

# 2. Navigate to your project directory
cd your-project

# 3a. If you use Claude Code:
cp ../kiro-agent-starter-kit/claude-code/CLAUDE.md .
cp -r ../kiro-agent-starter-kit/claude-code/.claude/ .
cp ../kiro-agent-starter-kit/AGENTS.md .

# 3b. If you use Kiro IDE:
cp -r ../kiro-agent-starter-kit/kiro/ .kiro/
cp ../kiro-agent-starter-kit/AGENTS.md .

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

## Quick Reference

| I am... | What should I do? |
|---------|-------------------|
| **Claude Code user** | Copy the Option A prompt, paste into your conversation |
| **Kiro IDE user** | Copy the Option B prompt, paste into your conversation |
| **Manual setup preferred** | Follow Option C steps |
| **Want to learn more** | Read [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) |
| **Want to see examples** | Check the [examples/](./examples/) folder |

## Directory Structure

```
kiro-agent-starter-kit/
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
    ├── pos-project/           # Full-featured Next.js + Supabase POS system
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
| **Claude Code** | ✅ Full | CLAUDE.md + .claude/rules/ |
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
