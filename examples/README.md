<!-- 2026-05-05 -->

# Examples

Real-world examples showing how to fill in the framework templates for your own project.

## pos-project/ — Full-Featured Example

A **Next.js + Supabase** POS system for a retail brand in Taiwan.

- 12 pages, complex business logic (promotions engine, inventory, reporting)
- Multi-location, multi-employee, offline-capable PWA
- Shows: detailed FILE_MAP with line counts, project-specific rules (SKU format, pricing), 3-layer QA strategy, source-of-truth data flow

**Files included:**
| File | Shows |
|------|-------|
| `AGENTS.md` | Full agent workflow with project-specific rules |
| `FILE_MAP.md` | Detailed file map for a medium-sized app (~20 files) |
| `PROJECT_BRIEF.md` | Complete project brief for sub-agent context |

---

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

1. **Pick the example closest to your project size** (full or minimal)
2. **Copy the templates** from the kit root (`AGENTS.md`, etc.)
3. **Fill them in** using these examples as reference
4. **Delete sections you don't need** — the framework is meant to be trimmed

The key insight: these files are for AI agents, not humans. Write them to be unambiguous and scannable. Tables > prose. Rules > suggestions.

---

## What Makes a Good Example

- **Specific commands** — not "run tests" but `uv run pytest -x`
- **Concrete constraints** — not "be careful with the database" but "never DROP TABLE"
- **Real file paths** — not "the main module" but `app/main.py`
- **Actual numbers** — not "limit parallel work" but "max 2 agents (8GB RAM)"
