<!-- 2026-05-07 -->
<!-- TEMPLATE: Copy to your project root as FILE_MAP.md -->
<!-- List every file agents might interact with -->
<!-- Delete all <!-- TEMPLATE comments when done -->

# FILE_MAP.md — [PROJECT_NAME]

> Sub-agents must check this before creating new files.

---

## Rules

1. Before creating new files, check this map — no duplicates
2. New files go in the correct directory per conventions below
3. If unsure where a file belongs, ask in main context first

---

## Pages / Routes

| Path | Purpose | Notes |
|------|---------|-------|
| `[PATH]` | [DESCRIPTION] | [NOTES] |

**Convention**: [DESCRIBE — e.g., "one file per route in app/ directory"]

---

## Core Logic

| File | Purpose | Lines | Notes |
|------|---------|-------|-------|
| `[PATH]` | [DESCRIPTION] | ~[N] | [NOTES] |

**New logic rules**:
- Utilities → `[UTILS_DIR]/`
- Types → `[TYPES_DIR]/`
- Data access → `[DATA_DIR]/`

---

## Data Files

| File | Purpose | Source of Truth |
|------|---------|----------------|
| `[PATH]` | [DESCRIPTION] | [YES/NO] |

---

## Configuration

| File | Purpose |
|------|---------|
| `[PACKAGE_FILE]` | Dependencies and scripts |
| `[LINTER_CONFIG]` | Linting rules |
| `[ENV_FILE]` | Environment variables (DO NOT commit secrets) |

---

## Temporary / Scripts

| Purpose | Naming Format |
|---------|--------------|
| Database migrations | `YYYYMMDD-description.sql` |
| One-off scripts | `YYYYMMDD-description.[ext]` |

**Rules**: All temporary scripts go in `[TEMP_DIR]/`.

---

## Static Assets

| Directory | Purpose |
|-----------|---------|
| `[PUBLIC_DIR]/` | Publicly served files |
| `[IMAGES_DIR]/` | Image assets |

---

## Tests

| Directory | Purpose | Framework |
|-----------|---------|-----------|
| `[TEST_DIR]/` | [UNIT/E2E] | [FRAMEWORK] |

**Naming**: [e.g., `*.test.ts`, `test_*.py`]
