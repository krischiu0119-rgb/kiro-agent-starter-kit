<!-- 2026-05-05 -->
<!-- EXAMPLE: A minimal AGENTS.md for a small Python API project. -->
<!-- Shows that the framework scales down — you don't need all sections for a simple project. -->

# AGENTS.md — my-api

> A REST API built with FastAPI. Simple CRUD for a task management service.

## Project Context

- **Project**: my-api
- **Stack**: Python 3.12 + FastAPI + SQLAlchemy + PostgreSQL + Alembic
- **Build**: `uv run pytest`
- **Lint**: `uv run ruff check .`
- **Deploy**: `git push` → Railway (auto-deploy from main)
- **Docs**: http://localhost:8000/docs (Swagger UI)

---

## Core Workflow Rules

1. **Main context = planning only.** Implementation goes to sub-agents.
2. **Max parallel agents**: 2 (8GB RAM laptop). Queue if at capacity.
3. **Verification**: Every sub-agent must run `uv run pytest` and confirm pass.
4. **Task routing**: < 20 lines → do directly. 1-3 files → 1 executor. 4+ files → split + reviewer.

---

## QA Strategy

| Layer | Trigger | Command |
|-------|---------|---------|
| **Smoke** | After each task | `uv run pytest -x` (stop on first failure) |
| **Full** | Before deploy | `uv run pytest --cov=app` |

---

## File Placement

Before creating files, check `FILE_MAP.md`:
- Routes → `app/routes/`
- Models → `app/models/`
- Schemas → `app/schemas/`
- Business logic → `app/services/`
- Tests → `tests/` (mirror the `app/` structure)

---

## Project-Specific Rules

### Database
- Migrations via Alembic — never edit the database directly
- All migrations are additive (no DROP TABLE, no DELETE)
- Generate migrations: `uv run alembic revision --autogenerate -m "description"`
- Apply: `uv run alembic upgrade head`

### Code Style
- Ruff for linting and formatting
- Type hints on all function signatures
- Pydantic schemas for all request/response bodies

### Dependencies
- Managed via `pyproject.toml` with `uv`
- Pin exact versions for production deps
- Add new deps: `uv add package-name`

---

## Deployment Verification

After `git push` to main:
1. Check Railway dashboard for build status
2. Hit `/health` endpoint on live URL
3. If deploy fails, check Railway logs

---

*Planning → Main | Building → Executors | Tests → `uv run pytest` | Temp → temporary/YYYYMMDD-\*.md | Files → FILE_MAP.md*
