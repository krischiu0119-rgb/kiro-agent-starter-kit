<!-- 2026-05-08 -->

# Examples

Real-world examples showing how to fill in the framework templates for your own project.

## minimal-project/ — Minimal Example

A **Python FastAPI** REST API — simple CRUD service.

- Small team, 8GB laptop, 2 parallel agents max
- Shows: the framework works for small projects without overhead
- Proves you don't need every section — just the essentials

**Files included:**
| File | Shows |
|------|-------|
| `AGENTS.md` | Stripped-down workflow (~75 lines) |
| `FILE_MAP.md` | Simple file map (~50 lines) |

---

## How to Use These Examples

1. **Copy the templates** from the kit root (`AGENTS.md`, etc.)
2. **Fill them in** using this example as reference
3. **Delete sections you don't need** — the framework is meant to be trimmed

The key insight: these files are for AI agents, not humans. Write them to be unambiguous and scannable. Tables > prose. Rules > suggestions.

---

## What Makes a Good Example

- **Specific commands** — not "run tests" but `uv run pytest -x`
- **Concrete constraints** — not "be careful with the database" but "never DROP TABLE"
- **Real file paths** — not "the main module" but `app/main.py`
- **Actual numbers** — not "limit parallel work" but "max 2 agents (8GB RAM)"
