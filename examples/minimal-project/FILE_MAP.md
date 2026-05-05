<!-- 2026-05-05 -->
<!-- EXAMPLE: A minimal FILE_MAP for a small Python API project. -->
<!-- Shows that even a simple project benefits from documenting file placement. -->

# FILE_MAP.md — my-api

## Rules
1. Check here before creating files
2. Keep it simple — don't over-engineer the structure

---

## Source Code

| Path | Purpose |
|------|---------|
| `app/main.py` | FastAPI app entry point, middleware, lifespan |
| `app/routes/` | API route handlers (one file per resource) |
| `app/models/` | SQLAlchemy ORM models |
| `app/schemas/` | Pydantic request/response schemas |
| `app/services/` | Business logic (keeps routes thin) |
| `app/db.py` | Database session and engine setup |

---

## Tests

| Path | Purpose |
|------|---------|
| `tests/conftest.py` | Shared fixtures (test DB, client) |
| `tests/test_*.py` | Test files (mirror `app/` structure) |

---

## Config

| File | Purpose |
|------|---------|
| `pyproject.toml` | Dependencies, project metadata, tool config |
| `alembic.ini` | Database migration config |
| `alembic/versions/` | Migration files (auto-generated) |
| `.env` | Local environment variables (not committed) |
| `.env.example` | Template for required env vars |

---

## Temporary

| Purpose | Format |
|---------|--------|
| Scripts, experiments, one-off tasks | `temporary/YYYYMMDD-description.py` |

---

## Key Conventions

- One route file per resource: `app/routes/tasks.py`, `app/routes/users.py`
- One model file per table: `app/models/task.py`, `app/models/user.py`
- Schema files match models: `app/schemas/task.py`, `app/schemas/user.py`
- Service files match resources: `app/services/task_service.py`
- Don't create `utils.py` or `helpers.py` — put logic in the relevant service
