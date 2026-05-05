<!-- 2026-05-05 -->
# Migration Guide — AI Agent Workflow Starter Kit

> 如何在現有專案中導入此工作流框架
> How to adopt this framework in an existing project

---

## For Kiro IDE Users

### Step 1: Copy Steering Files

```bash
cp -r kiro-agent-starter-kit/kiro/ .kiro/
```

This gives you the steering files and hooks that Kiro IDE reads automatically.

### Step 2: Create AGENTS.md

Create `AGENTS.md` at your project root. Use the template from this kit:

```bash
cp kiro-agent-starter-kit/AGENTS.md ./AGENTS.md
```

Then fill in the placeholders:
- `[PROJECT_NAME]` → your project name
- `[TECH_STACK]` → e.g., "Next.js 15 + Supabase + Tailwind"
- `[DEPLOY_PLATFORM]` → e.g., "Vercel"

### Step 3: Create FILE_MAP.md

Document your project's file structure. This is critical — agents use it to decide where new files go.

```markdown
# FILE_MAP.md

## Directory Rules
- `app/` — Next.js pages and routes
- `lib/` — Shared utilities and business logic
- `contexts/` — React context providers
- `data/` — Static data files (JSON)
- `temporary/` — Scripts, migrations, one-time tasks (date-prefixed)
- `docs/` — Project documentation
```

### Step 4: Customize Steering Files

In `.kiro/steering/`, update:

| File | What to Change |
|------|---------------|
| `subagent-workflow.md` | Build/test commands for your project |
| `database-safety.md` | Your DB platform (Supabase/Postgres/etc.) |
| `deployment-verification.md` | Your deploy platform and URLs |
| `file-placement.md` | Your directory structure rules |

### Step 5: Enable Hooks (One at a Time)

Start with hooks **disabled**. Enable them gradually:

1. **Week 1**: Enable `housekeeping` hook only
2. **Week 2**: Enable `qa-smoke` hook
3. **Week 3**: Enable file-placement pre-check hook

This prevents overwhelming the workflow with too many checks at once.

### Step 6: Onboard the Agent

Tell the agent:

```
讀 AGENTS.md 和 .kiro/steering/ 裡的所有檔案，理解這個專案的工作方式
```

The agent will read all steering files and adopt the workflow rules.

---

## For Claude Code Users

### Step 1: Copy CLAUDE.md

```bash
cp kiro-agent-starter-kit/claude-code/CLAUDE.md ./CLAUDE.md
```

### Step 2: Copy Rules Directory

```bash
cp -r kiro-agent-starter-kit/claude-code/.claude/ ./.claude/
```

### Step 3: Create AGENTS.md

```bash
cp kiro-agent-starter-kit/AGENTS.md ./AGENTS.md
```

Fill in the placeholders as described above.

### Step 4: Customize CLAUDE.md

Edit `CLAUDE.md` with your project specifics:
- Project name and description
- Build/test/deploy commands
- Key file locations
- Any project-specific rules

Keep CLAUDE.md under 200 lines. If it grows beyond that, split rules into `.claude/rules/`.

### Step 5: Onboard the Agent

Tell Claude:

```
Read AGENTS.md and .claude/rules/ to understand the workflow
```

---

## For Mixed Teams (Kiro + Claude Code)

When team members use different tools:

### Single Source of Truth

`AGENTS.md` is the **canonical workflow definition**. All tool-specific files reference it.

```
AGENTS.md (source of truth)
    ├── .kiro/steering/ (Kiro reads this)
    └── CLAUDE.md + .claude/rules/ (Claude Code reads this)
```

### Keeping in Sync

- Workflow changes go to `AGENTS.md` first
- Then propagate to tool-specific files
- Keep tool-specific files as thin wrappers that point to AGENTS.md concepts
- Store shared documentation in `docs/` (tool-agnostic)

### What Goes Where

| Content | Location | Why |
|---------|----------|-----|
| Workflow rules | `AGENTS.md` | Cross-platform, everyone reads it |
| Build commands | Tool-specific files | Different tools parse differently |
| File placement | `FILE_MAP.md` | Shared, referenced by all tools |
| QA checklists | `docs/` | Tool-agnostic documentation |

---

## Recommended Adoption Timeline

Don't try to adopt everything at once. Follow this 4-week plan:

### Week 1: Foundation
- [ ] Create `AGENTS.md` with project context and build commands
- [ ] Create `FILE_MAP.md` documenting current structure
- [ ] Tell the agent to read these files at session start
- [ ] Observe: does the agent follow the rules?

### Week 2: Sub-Agent Workflow
- [ ] Enable sub-agent delegation for medium/large tasks
- [ ] Set up `temporary/` folder for agent communication
- [ ] Add task size routing rules
- [ ] Practice: give the agent a medium task, watch it delegate

### Week 3: QA Automation
- [ ] Enable Layer 1 (Smoke) — build check after every task
- [ ] Enable Layer 2 (Regression) — test suite after features
- [ ] Set up the Reviewer agent role
- [ ] Verify: agent catches its own build errors before reporting done

### Week 4: Full Framework
- [ ] Enable Housekeeping agent (audit log, cleanup)
- [ ] Enable Layer 3 (Full Audit) before deploys
- [ ] Add deployment verification checks
- [ ] Enable database safety rules
- [ ] Review and tune: adjust rules based on first month's experience

---

## Tips & Lessons Learned

### Start Simple
Start with hooks **DISABLED**. Enable one at a time. If you enable everything at once, you'll spend more time debugging the framework than building features.

### Learn from Mistakes
Every time the agent makes a mistake, add a rule to `AGENTS.md`. Examples:
- Agent created a file in the wrong place → add to FILE_MAP.md
- Agent forgot to run build → strengthen verification rule
- Agent used a deprecated API → add "research before recommending" rule

### Keep CLAUDE.md Short
If CLAUDE.md exceeds 200 lines, split into `.claude/rules/`:
```
.claude/rules/
├── workflow.md          # Sub-agent delegation rules
├── database-safety.md  # Migration rules
└── deploy.md           # Verification checklist
```

### Don't Over-Engineer
The framework is meant to **evolve**. Don't try to perfect it upfront.
- Start with 5 rules, not 50
- Add rules reactively (when something goes wrong)
- Remove rules that never trigger
- 框架是活的，讓它隨專案成長

### File Naming Convention
Temporary and migration files should always be date-prefixed:
```
temporary/20260505-migration-add-column.sql
temporary/20260505-qa-report.md
temporary/20260505-research-auth-options.md
```

### Agent Onboarding Prompt
At the start of every session, use this prompt:
```
讀 AGENTS.md，理解工作流。今天的任務是：[YOUR TASK]
```

This ensures the agent loads the workflow rules before starting work.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Agent ignores AGENTS.md | Explicitly tell it to read the file at session start |
| Too many sub-agents spawned | Reduce max in AGENTS.md, increase task size thresholds |
| Hooks blocking valid files | Adjust file placement rules in steering/FILE_MAP |
| Agent skips build verification | Add "NEVER skip build" in bold to AGENTS.md |
| Mixed team conflicts | Ensure AGENTS.md is the single source, not tool-specific files |

---

## Next Steps

After adoption:
1. Customize the QA checklist for your project's specific needs
2. Add project-specific rules as you discover patterns
3. Share your AGENTS.md with the team for review
4. Consider contributing improvements back to this starter kit
