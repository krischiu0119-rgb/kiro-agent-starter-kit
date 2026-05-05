<!-- 2026-05-05 -->

# Code Execution Practices

> For the cross-platform source of truth, see `AGENTS.md`.

## Core Principle

**Never run complex code inline in the terminal.** Always create a proper file, then run it. This gives you reusability, better error messages with line numbers, and a cleaner command history.

## Temporary Code Files

When you need to run code for testing, debugging, or one-time operations:

### Process

1. Ensure `[TEMP_DIR]` exists (default: `temporary/` at workspace root)
2. Create a file with date prefix: `YYYYMMDD-description.{ext}`
3. Write the code to the file
4. Run the file using the appropriate interpreter

### File Naming Convention

```
[TEMP_DIR]/YYYYMMDD-description.{ext}

Examples:
  temporary/20260505-test-api-response.py
  temporary/20260505-migrate-data.mjs
  temporary/20260505-check-schema.sql
  temporary/20260505-benchmark-query.ts
```

### Running Files

```bash
# Python
python [TEMP_DIR]/20260505-test-api.py

# Node.js
node [TEMP_DIR]/20260505-check-data.mjs

# TypeScript (with ts-node or tsx)
npx tsx [TEMP_DIR]/20260505-validate.ts

# SQL (via CLI)
psql -f [TEMP_DIR]/20260505-migration.sql
```

## What Counts as "Complex"

**Create a file** when the command involves:
- JSON parsing or data transformation
- Multiple sequential operations
- API calls with response processing
- Database queries with output formatting
- Any logic with conditionals or loops
- File manipulation beyond simple copy/move

**Inline is OK** for:
- Simple file operations (`ls`, `cat`, `cp`, `mv`)
- Single-line text transforms (`echo`, simple `sed`)
- Environment checks (`which`, `node --version`, `env | grep`)
- Quick tests without complex logic (`curl -I`, `ping`)

## Examples

### ❌ BAD — Complex inline
```bash
curl -s https://api.example.com/data | python3 -c "import sys, json; data = json.load(sys.stdin); [print(f'{k}: {v}') for k, v in data.items() if v > 100]"
```

### ✅ GOOD — File-based
```bash
# Create the file
# → temporary/20260505-check-api.py

# Run it
python temporary/20260505-check-api.py
```

### ❌ BAD — Multi-step inline
```bash
node -e "const fs = require('fs'); const data = JSON.parse(fs.readFileSync('data.json')); const filtered = data.filter(x => x.active); fs.writeFileSync('output.json', JSON.stringify(filtered, null, 2));"
```

### ✅ GOOD — File-based
```bash
# → temporary/20260505-filter-data.mjs
node temporary/20260505-filter-data.mjs
```

## Cleanup

- Temporary files can be deleted after use or kept for reference
- Add `[TEMP_DIR]/` to `.gitignore` if not already present
- Periodically clean up old temporary files (files older than 30 days are usually safe to remove)
- Migration scripts that were run on production should be kept as documentation

## Enforcement

Claude Code has no file-creation hooks. Enforcement is via:
1. This rule file (loaded automatically into context)
2. Self-discipline — before writing a complex inline command, stop and create a file instead
3. Sub-agent prompts should include: "Use file-based execution per `.claude/rules/code-execution-practices.md`"

---

## Customization

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[TEMP_DIR]` | Directory for temporary/scratch files | `temporary/`, `tmp/`, `scripts/scratch/` |

Additional customization:
- **Interpreters**: Add your project's specific runtime commands (e.g., `uv run python`, `bun run`)
- **Cleanup policy**: Define how long to keep temporary files
- **Git ignore**: Ensure your temp directory is in `.gitignore`
- **Naming convention**: Adjust the date format or add category prefixes if needed
