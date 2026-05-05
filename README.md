<!-- 2026-05-05 -->
# AI Agent Workflow Starter Kit

> 跨專案通用的 AI 開發工作流框架

A reusable framework for structured AI-assisted development using sub-agents (Planner/Executor/Reviewer pattern), 3-layer QA, and automated housekeeping. Drop it into any project and get consistent, reliable agent behavior from day one.

## Who Is This For?

Teams using **Kiro IDE** or **Claude Code** who want:
- Consistent agent behavior across multiple projects
- Structured delegation (no more 500-line single-agent chaos)
- Automated quality gates that catch issues before deploy
- A shared workflow that works regardless of which AI tool team members prefer

## Quick Start

| Scenario | Steps |
|----------|-------|
| **New project + Kiro IDE** | Copy `kiro/` folder → `.kiro/` in your project root |
| **New project + Claude Code** | Copy `claude-code/` contents → your project root |
| **Existing project** | Follow [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) |

After copying, tell the agent:

```
讀 AGENTS.md 和所有 steering/rules 檔案，理解這個專案的工作方式
```

## Directory Structure

```
kiro-agent-starter-kit/
├── AGENTS.md                  # Cross-platform source of truth (所有工具共用)
├── MIGRATION_GUIDE.md         # Adoption guide for existing projects
├── README.md                  # You are here
│
├── kiro/                      # For Kiro IDE users → copy to .kiro/
│   ├── steering/
│   │   ├── subagent-workflow.md
│   │   ├── database-safety.md
│   │   ├── deployment-verification.md
│   │   └── file-placement.md
│   └── hooks/
│       ├── housekeeping.md
│       └── qa-smoke.md
│
├── claude-code/               # For Claude Code users → copy to project root
│   ├── CLAUDE.md
│   └── .claude/
│       └── rules/
│           ├── workflow.md
│           ├── database-safety.md
│           └── deployment-verification.md
│
└── docs/                      # Shared documentation templates
    ├── FILE_MAP_TEMPLATE.md
    └── QA_CHECKLIST.md
```

## Key Concepts

### Sub-Agent Workflow（子代理工作流）

The main context is for **planning only**. All implementation is delegated to sub-agents:

| Role | Responsibility |
|------|---------------|
| **Planner** | Breaks tasks into steps, assigns to executors |
| **Executor** | Implements one focused task, verifies with build |
| **Reviewer** | Checks output quality, runs QA layers |

### 3-Layer QA Strategy（三層品質策略）

| Layer | When | What |
|-------|------|------|
| **Smoke** | After every sub-agent task | Build passes, no type errors, basic functionality |
| **Regression** | After feature complete | Run full test suite, check existing features unbroken |
| **Full Audit** | Before deploy / end of batch | Deep check: edge cases, mobile, accessibility, security |

### Housekeeping Agent（整理代理）

Runs periodically (or on trigger) to:
- Update `audit_log.md` with batch summaries
- Clean up `temporary/` files older than 7 days
- Verify `FILE_MAP.md` matches actual project structure
- Flag TODOs that have been open > 2 weeks

### File Placement Rules（檔案放置規則）

Before creating any new file, agents **must** check `FILE_MAP.md` to determine the correct location. No guessing, no "I'll put it here for now."

### Database Safety（資料庫安全）

- Migrations are **additive only** — never DROP columns/tables without explicit approval
- All migrations go through `temporary/` first for review
- Production data is sacred（正式環境資料神聖不可侵犯）

### Deployment Verification（部署驗證）

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

好的規則來自真實的錯誤 — Good rules come from real mistakes.

## License

MIT
