<!-- 2026-05-07 -->
# Token Budget Guidelines

> Every token in your rule files is loaded on every single interaction. Write less, pay less, get faster responses.

---

## Why It Matters

Agent rule files are injected into the context window at the start of every conversation turn. Unlike code files (read on demand), rules are **always present**. This means:

- More tokens = higher cost per interaction
- More tokens = less room for actual work context
- More tokens = slower response times
- Verbose examples in rules = wasted budget (the agent doesn't need examples to follow rules)

---

## Recommended Budgets

| File | Target | Hard Limit |
|------|--------|------------|
| `AGENTS.md` | 400-500 tokens | 600 tokens |
| `CLAUDE.md` | 350-450 tokens | 550 tokens |
| `core.md` (all rules) | 600-700 tokens | 900 tokens |
| Per steering file (auto) | 150-300 tokens | 400 tokens |
| Per steering file (manual) | 150-250 tokens | 350 tokens |
| **Total always-loaded** | **~1,500 tokens** | **2,000 tokens** |

---

## Writing Guidelines

1. Use imperative sentences: "Run build before reporting done" not "The agent should always ensure that the build command has been executed successfully before it reports completion"
2. Use tables for structured data — more compact than prose
3. No examples in agent-facing files — put examples in `docs/CUSTOMIZATION_GUIDE.md`
4. No explanations of *why* — the agent doesn't need motivation, just instructions
5. One rule per line — no multi-sentence paragraphs
6. Use abbreviations the agent understands: "DB" not "database", "config" not "configuration"
7. Delete filler words: "please", "always", "make sure to", "it is important that"
8. Combine related rules into single lines with semicolons
9. Use markdown tables instead of nested bullet lists
10. Never repeat information across files — single source of truth

---

## Before vs After

### Before (~21,000 tokens across all files)

```markdown
## Database Safety Rules

When working with database migrations, it is extremely important to follow
these safety guidelines to prevent data loss in production environments.

### Additive Operations (Safe)

The following operations are considered safe and can be performed without
explicit user approval:

- Adding a new column: Use `ALTER TABLE ... ADD COLUMN IF NOT EXISTS`
- Creating an index: Use `CREATE INDEX IF NOT EXISTS`
- Creating a new table: Use `CREATE TABLE IF NOT EXISTS`

### Destructive Operations (Require Approval)

The following operations are considered destructive and MUST NOT be performed
without getting explicit approval from the user first:

- Dropping a table: `DROP TABLE` — this permanently deletes all data
- Dropping a column: `DROP COLUMN` — this removes data from all rows
- Truncating: `TRUNCATE` — this removes all rows without logging
- Delete without WHERE: `DELETE FROM table` — this removes all rows

### Migration File Conventions

All migration files should follow these naming conventions:
- Use a date prefix in the format YYYYMMDD
- Include a descriptive name after the date
- Place all migration files in the designated migrations directory
- Ensure migrations are idempotent (can be run multiple times safely)
```

### After (~200 tokens in agent file)

```markdown
## DB Rules
- Additive only: ADD COLUMN IF NOT EXISTS, CREATE INDEX IF NOT EXISTS.
- Forbidden without approval: DROP TABLE, DROP COLUMN, TRUNCATE, DELETE without WHERE.
- Before NOT NULL: fill NULLs first. Before UNIQUE: verify no duplicates.
- Migrations: idempotent, date-prefixed, in `[MIGRATIONS_DIR]`.
- New columns: DEFAULT or nullable.
```

**Result: 95% reduction** — same behavioral outcome, fraction of the cost.

---

## How to Measure Tokens

### Quick estimate
- 1 token ≈ 4 characters (English text)
- 1 token ≈ 0.75 words
- Count characters, divide by 4

### Precise count
```bash
# Using Claude Code CLI
claude -p "Count the tokens in this file" < .claude/rules/core.md

# Using tiktoken (Python)
pip install tiktoken
python -c "
import tiktoken
enc = tiktoken.get_encoding('cl100k_base')
text = open('.claude/rules/core.md').read()
print(f'{len(enc.encode(text))} tokens')
"
```

### Rule of thumb
If your rule file is longer than 40 lines, it's probably over budget. Compress it.

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| SQL examples in agent rules | Move to `docs/CUSTOMIZATION_GUIDE.md` |
| Explaining *why* a rule exists | Delete — agent doesn't need motivation |
| Platform setup instructions in rules | Move to `docs/CUSTOMIZATION_GUIDE.md` |
| Duplicate rules across files | Single source of truth in one file |
| "Please ensure that..." | "Do X" |
| Multi-paragraph descriptions | Single imperative sentence |
