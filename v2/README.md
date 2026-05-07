<!-- 2026-05-07 -->
# Kiro Agent Starter Kit v2

> Pre-built agent rules for AI-assisted development. ~1,700 tokens loaded per interaction (down from ~21,000 in v1).

---

## 5-Minute Setup

### Claude Code (Primary)

```bash
# 1. Copy agent rules into your project
cp -r claude-code/.claude your-project/
cp claude-code/CLAUDE.md your-project/
cp AGENTS.md your-project/

# 2. Replace placeholders
cd your-project
sed -i '' 's/\[PROJECT_NAME\]/my-app/g' AGENTS.md CLAUDE.md
sed -i '' 's/\[BUILD_COMMAND\]/npm run build/g' AGENTS.md CLAUDE.md .claude/rules/core.md
sed -i '' 's/\[TEST_COMMAND\]/npm test/g' AGENTS.md .claude/rules/core.md
sed -i '' 's/\[TEMP_DIR\]/temporary/g' CLAUDE.md .claude/rules/core.md
sed -i '' 's/\[MIGRATIONS_DIR\]/migrations/g' .claude/rules/core.md
sed -i '' 's/\[DEPLOY_PLATFORM\]/Vercel/g' AGENTS.md CLAUDE.md
sed -i '' 's/\[TECH_STACK\]/Next.js + TypeScript/g' AGENTS.md CLAUDE.md

# 3. Done — start Claude Code
claude
```

### Kiro IDE (Backup)

```bash
# 1. Copy steering files and hooks
cp -r kiro/.kiro your-project/
cp AGENTS.md your-project/

# 2. Replace placeholders (same as above)

# 3. Done — open in Kiro IDE
```

---

## Directory Structure

```
v2/
├── AGENTS.md                          ← Cross-platform rules (~450 tokens)
├── README.md                          ← This file
├── FUTURE_ROADMAP.md                  ← Enterprise vision (no timelines)
│
├── claude-code/                       ← Claude Code platform files
│   ├── CLAUDE.md                      ← Entry point (~400 tokens)
│   └── .claude/rules/
│       └── core.md                    ← All behavioral rules (~650 tokens)
│
├── kiro/                              ← Kiro IDE platform files
│   ├── steering/
│   │   ├── workflow.md                ← Auto-loaded (~500 tokens)
│   │   ├── code-execution.md         ← Auto-loaded (~170 tokens)
│   │   ├── git-safety.md             ← Auto-loaded (~150 tokens)
│   │   ├── database-safety.md        ← Manual/on-demand (~200 tokens)
│   │   └── deployment.md             ← Manual/on-demand (~180 tokens)
│   └── hooks/
│       └── *.kiro.hook                ← Event-triggered automation
│
├── docs/                              ← Human documentation (never loaded by agent)
│   ├── CUSTOMIZATION_GUIDE.md         ← All customization options + examples
│   ├── TOKEN_BUDGET.md                ← Writing efficient rules
│   ├── MODEL_ROUTING.md              ← Per-agent model selection
│   ├── MCP_GUIDE.md                  ← MCP server setup
│   └── LEARNING_RESOURCES.md         ← Courses and learning path
│
└── templates/                         ← Copy-paste starters (never loaded by agent)
    ├── agents/
    │   ├── orchestrator.md            ← Opus planner agent
    │   ├── implementer.md             ← Sonnet executor agent
    │   └── explorer.md                ← Haiku lookup agent
    ├── automation/
    │   ├── batch-refactor.sh          ← CLI batch processing
    │   ├── ci-review.sh              ← CI/CD PR review
    │   └── scheduled-audit.sh        ← Scheduled code audit
    ├── AGENTS.template.md             ← Blank AGENTS.md with placeholders
    ├── FILE_MAP.template.md           ← Blank file map
    ├── PROJECT_BRIEF.template.md      ← Blank project brief
    ├── audit_log.template.md          ← Audit log format
    ├── MODEL_POLICY.template.md       ← Model governance policy
    └── mcp.template.json             ← MCP server configuration
```

---

## Key Concepts

### Agent-facing vs Human-facing

| Category | Loaded by Agent | Purpose |
|----------|----------------|---------|
| `AGENTS.md`, `CLAUDE.md`, `core.md` | ✅ Every interaction | Behavioral rules |
| `kiro/steering/*.md` | ✅ Per inclusion mode | Platform-specific rules |
| `docs/*.md` | ❌ Never | Human reference |
| `templates/*` | ❌ Never | Copy-paste starters |

### Token Budget

The entire always-loaded rule set is ~1,700 tokens. This is intentional — every token costs money on every interaction. See [docs/TOKEN_BUDGET.md](docs/TOKEN_BUDGET.md).

### Model Routing

Use expensive models for planning, cheap models for lookup:
- **Tier 1 (Opus)**: Architecture, review, complex reasoning
- **Tier 2 (Sonnet)**: Implementation, refactoring, testing
- **Tier 3 (Haiku)**: File search, simple transforms

See [docs/MODEL_ROUTING.md](docs/MODEL_ROUTING.md).

### Model Version Variables

Model IDs in this kit (e.g., `claude-opus-4-6`, `claude-sonnet-4-5`, `claude-haiku-4-5`) are **variables you update** when new models release. They're defined in `templates/MODEL_POLICY.template.md`.

- **Claude Code users**: The Freshness Agent (future — see FUTURE_ROADMAP.md) will auto-update these.
- **Kiro users**: Update manually when new models release.

---

## Customization

See [docs/CUSTOMIZATION_GUIDE.md](docs/CUSTOMIZATION_GUIDE.md) for:
- Complete placeholder reference
- Rule customization (workflow, DB safety, deployment, git, code execution)
- Platform setup instructions
- Token budget quick reference

---

## MCP Setup

See [docs/MCP_GUIDE.md](docs/MCP_GUIDE.md) for:
- Essential kit (4 MCPs): fetch, web-search, github, Context7
- Optional add-ons: google-sheets, playwright, aws-knowledge
- Auto-approve best practices
- Configuration template

---

## Future

See [FUTURE_ROADMAP.md](FUTURE_ROADMAP.md) for enterprise vision:
- Freshness Agent, Librarian Agent, AI Governance Layer
- A/B Testing Harness, Progressive MCP Disclosure
- Enterprise Skill Management, Agent-Suggested Learning

---

## License

MIT
