<!-- 2026-05-07 -->
# Customization Guide

> Everything you need to configure the Kiro Agent Starter Kit for your project.

---

## Overview

This kit provides pre-built agent rules for AI-assisted development. It works with:

- **Claude Code** (primary platform) — rules in `.claude/rules/`, entry point `CLAUDE.md`
- **Kiro IDE** (backup platform) — steering files in `.kiro/steering/`, hooks in `.kiro/hooks/`

The agent reads slim, terse rule files (~1,700 tokens total). This guide is for *you* — it never gets loaded by the agent.

---

## Quick Start

1. Copy the `claude-code/` or `kiro/` folder into your project root
2. Copy `AGENTS.md` into your project root
3. Replace all `[PLACEHOLDERS]` with your project values
4. Done — the agent now follows your rules

---

## Placeholder Reference

Every placeholder in the kit. Replace all of them before first use.

| Placeholder | Where Used | Example Value |
|-------------|-----------|---------------|
| `[PROJECT_NAME]` | AGENTS.md, CLAUDE.md | `acme-dashboard` |
| `[TECH_STACK]` | AGENTS.md, CLAUDE.md | `Next.js 14 + TypeScript + Supabase` |
| `[BUILD_COMMAND]` | AGENTS.md, CLAUDE.md, core.md | `npm run build` |
| `[TEST_COMMAND]` | AGENTS.md, core.md | `npm test` |
| `[TEMP_DIR]` | CLAUDE.md, core.md | `temporary` |
| `[MIGRATIONS_DIR]` | core.md | `supabase/migrations` |
| `[DEPLOY_PLATFORM]` | AGENTS.md, CLAUDE.md | `Vercel` |

### How to replace

```bash
# macOS/Linux — replace all at once
find . -name "*.md" -exec sed -i '' 's/\[BUILD_COMMAND\]/npm run build/g' {} +
```

Or just open each file and Ctrl+H.

---

## Rule Customization

### Workflow Rules

**What you can change:**
- Task size thresholds (when to delegate vs. do directly)
- Max parallel sub-agents (depends on your machine's RAM)
- QA layer triggers

**Examples:**

| Setting | Small Project | Large Monorepo |
|---------|--------------|----------------|
| Small task threshold | ≤3 files | ≤1 file |
| Max parallel agents | 2 | 4 |
| Full audit trigger | Before deploy | Every PR |

**Where to edit:**
- Claude Code: `.claude/rules/core.md` → Task Routing table
- Kiro: `.kiro/steering/workflow.md` → Routing section

---

### Database Safety

**What you can change:**
- Which operations require approval
- Migration file naming convention
- Migration directory path

**Default forbidden operations (require explicit approval):**
- `DROP TABLE`
- `DROP COLUMN`
- `TRUNCATE`
- `DELETE` without `WHERE` clause
- `ALTER TABLE ... DROP CONSTRAINT`

**SQL examples — what the agent will do automatically:**

```sql
-- ✅ Agent will run these without asking
ALTER TABLE users ADD COLUMN IF NOT EXISTS avatar_url TEXT;
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
ALTER TABLE orders ADD COLUMN notes TEXT DEFAULT '';

-- ⚠️ Agent will ASK before running these
DROP TABLE legacy_sessions;
ALTER TABLE users DROP COLUMN old_field;
TRUNCATE TABLE temp_imports;
DELETE FROM logs;  -- no WHERE clause
```

**Safe migration pattern the agent follows:**

```sql
-- Before adding NOT NULL constraint:
UPDATE products SET category = 'uncategorized' WHERE category IS NULL;
ALTER TABLE products ALTER COLUMN category SET NOT NULL;

-- Before adding UNIQUE constraint:
-- Agent checks: SELECT category, COUNT(*) FROM products GROUP BY category HAVING COUNT(*) > 1;
-- Only proceeds if no duplicates found
```

**Where to edit:**
- Claude Code: `.claude/rules/core.md` → DB Rules section
- Kiro: `.kiro/steering/database-safety.md`

---

### Deployment Verification

**What you can change:**
- Wait time after push (default: 20s)
- Verification method (curl, browser, CLI)
- Platform-specific checks

**Platform examples:**

| Platform | How agent verifies |
|----------|-------------------|
| Vercel | Check Vercel CLI or dashboard for build status |
| Railway | `railway status` or check dashboard URL |
| AWS Amplify | Check Amplify console build status |
| Netlify | Check deploy log via Netlify CLI |
| Self-hosted | `curl -s https://your-site.com/health` |

**Where to edit:**
- Claude Code: `.claude/rules/core.md` → Deployment Verification section
- Kiro: `.kiro/steering/deployment.md`

---

### Code Execution

**What you can change:**
- Temp directory name
- File naming convention
- What counts as "simple" (inline OK)

**Default rule:** Complex code goes to a file; simple commands run inline.

| Inline OK | Must use file |
|-----------|---------------|
| `ls`, `cat`, `grep` | JSON parsing |
| Version checks | API calls with processing |
| Single-line transforms | Multi-step data transforms |
| `git status` | Database queries with logic |

**Where to edit:**
- Claude Code: `.claude/rules/core.md` → Code Execution section
- Kiro: `.kiro/steering/code-execution.md`

---

### Git Safety

**What you can change:**
- Branch naming convention
- Whether force-push ever allowed
- Pre-push checks

**Default rules:**
1. Feature branches preferred; never commit directly to main without reason
2. Force-push requires explicit user approval
3. Build + test must pass before push
4. Destructive ops (reset --hard, branch -D, rebase published) require approval

**Where to edit:**
- Claude Code: `.claude/rules/core.md` → Git Safety section
- Kiro: `.kiro/steering/git-safety.md`

---

## Platform Setup

### Claude Code

**File locations:**
```
your-project/
├── CLAUDE.md                    ← Entry point (always loaded)
├── AGENTS.md                    ← Cross-platform rules (always loaded)
└── .claude/
    └── rules/
        └── core.md              ← All behavioral rules (always loaded)
```

**How rules load:** Claude Code reads `CLAUDE.md` at session start, then loads all `.md` files in `.claude/rules/` automatically. No configuration needed — just place files and they're active.

**Adding new rules:** Create a new `.md` file in `.claude/rules/`. It loads automatically next session.

**Disabling rules:** Delete or rename the file (e.g., `core.md` → `core.md.disabled`).

---

### Kiro IDE

**File locations:**
```
your-project/
├── AGENTS.md                    ← Cross-platform rules
└── .kiro/
    ├── steering/
    │   ├── workflow.md           ← Auto-loaded
    │   ├── code-execution.md    ← Auto-loaded
    │   ├── git-safety.md        ← Auto-loaded
    │   ├── database-safety.md   ← Manual (on-demand)
    │   └── deployment.md        ← Manual (on-demand)
    └── hooks/
        └── *.kiro.hook          ← Event-triggered
```

**YAML frontmatter controls inclusion mode:**

```yaml
---
inclusion: auto        # Loaded every session
---
# Rule content here
```

```yaml
---
inclusion: manual      # Only loaded when explicitly activated
---
# Rule content here
```

**Inclusion modes:**
- `auto` — loaded on every interaction (use for universal rules)
- `manual` — loaded only when user or agent activates it (use for situational rules)

**Adding new steering:** Create a `.md` file in `.kiro/steering/` with appropriate frontmatter.

**Hooks:** Event-triggered actions (file edit, deploy, etc.). See hook files for format.

---

## Token Budget

Every token in your rule files is loaded on every interaction. Keep rules terse.

See [TOKEN_BUDGET.md](./TOKEN_BUDGET.md) for detailed guidelines on writing efficient rules.

**Quick reference:**

| Rule Type | Target Budget |
|-----------|--------------|
| Core rules (always loaded) | < 800 tokens |
| Per-steering file | < 300 tokens |
| CLAUDE.md entry point | < 500 tokens |
| AGENTS.md | < 500 tokens |

---

## Related Guides

- [TOKEN_BUDGET.md](./TOKEN_BUDGET.md) — Writing efficient rules
- [MODEL_ROUTING.md](./MODEL_ROUTING.md) — Per-agent model selection
- [MCP_GUIDE.md](./MCP_GUIDE.md) — MCP server setup
- [LEARNING_RESOURCES.md](./LEARNING_RESOURCES.md) — Courses and learning path
