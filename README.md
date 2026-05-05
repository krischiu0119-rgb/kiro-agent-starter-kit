<!-- 2026-05-05 -->
# AI Agent Workflow Starter Kit

> 跨專案通用的 AI 開發工作流框架

A reusable framework for structured AI-assisted development using sub-agents (Planner/Executor/Reviewer pattern), 3-layer QA, and automated housekeeping. Drop it into any project and get consistent, reliable agent behavior from day one.

## Who Is This For?

Teams using **Kiro IDE** or **Claude Code** who want:
- Consistent agent behavior across multiple projects
- Structured delegation (no more 500-line single-agent chaos)
- Automated quality gates that catch issues before deploy
- A shared workflow that works regardless of which AI tool team members prefer

---

## 🚀 5-Minute Setup（五分鐘快速導入）

### Option A: Claude Code 用戶（最簡單 — 貼一段 prompt 就好）

把下面這段 prompt **整段複製**，貼到你的 Claude Code 對話裡。它會自動幫你設定好一切：

```
我要導入一個 AI agent 工作流框架到這個專案。

請從這個 GitHub repo 取得框架內容：
https://github.com/krischiu0119-rgb/kiro-agent-starter-kit

然後執行以下步驟：

1. 用 fetch 或 GitHub API 讀取 repo 中 claude-code/ 資料夾的所有檔案
2. 把 claude-code/CLAUDE.md 的內容寫到我專案根目錄的 CLAUDE.md
3. 把 claude-code/.claude/rules/ 裡的所有 .md 檔案寫到我專案的 .claude/rules/ 目錄
4. 讀取 repo 根目錄的 AGENTS.md，寫到我專案根目錄
5. 分析我目前的專案結構，然後：
   - 生成一份 FILE_MAP.md（記錄每個重要檔案的位置和用途）
   - 生成一份 PROJECT_BRIEF.md（專案摘要，讓 sub-agent 能快速理解專案）
6. 把 AGENTS.md 和 CLAUDE.md 裡所有的 [PLACEHOLDER]（如 [BUILD_COMMAND]、[PROJECT_NAME] 等）替換成我這個專案的實際值
7. 建立 temporary/ 資料夾（如果不存在）
8. 建立 audit_log.md（如果不存在）

完成後，給我一份摘要：你做了什麼、改了哪些檔案、以及我接下來該怎麼使用這個框架。
```

**就這樣！** Claude 會自動完成所有設定。

---

### Option B: Kiro IDE 用戶（同樣簡單）

把下面這段 prompt 貼到 Kiro 的對話裡：

```
我要導入一個 AI agent 工作流框架。

請從這個 GitHub repo 取得框架內容：
https://github.com/krischiu0119-rgb/kiro-agent-starter-kit

然後執行以下步驟：

1. 用 fetch 或 GitHub API 讀取 repo 中 kiro/ 資料夾的所有檔案
2. 把 kiro/steering/ 裡的所有 .md 檔案寫到我專案的 .kiro/steering/ 目錄
3. 把 kiro/hooks/ 裡的所有 .kiro.hook 檔案寫到我專案的 .kiro/hooks/ 目錄
4. 讀取 repo 根目錄的 AGENTS.md，寫到我專案根目錄
5. 分析我目前的專案結構，然後：
   - 生成一份 FILE_MAP.md（記錄每個重要檔案的位置和用途）
   - 生成一份 PROJECT_BRIEF.md（專案摘要，讓 sub-agent 能快速理解專案）
6. 把所有 [PLACEHOLDER] 替換成我這個專案的實際值
7. 建立 temporary/ 資料夾（如果不存在）
8. 建立 audit_log.md（如果不存在）

完成後，給我一份摘要：你做了什麼、改了哪些檔案、以及我接下來該怎麼使用這個框架。
```

---

### Option C: 手動安裝（適合想完全控制的人）

```bash
# 1. Clone this repo
git clone https://github.com/krischiu0119-rgb/kiro-agent-starter-kit.git

# 2. 進入你的專案目錄
cd your-project

# 3a. 如果你用 Claude Code：
cp ../kiro-agent-starter-kit/claude-code/CLAUDE.md .
cp -r ../kiro-agent-starter-kit/claude-code/.claude/ .
cp ../kiro-agent-starter-kit/AGENTS.md .

# 3b. 如果你用 Kiro IDE：
cp -r ../kiro-agent-starter-kit/kiro/ .kiro/
cp ../kiro-agent-starter-kit/AGENTS.md .

# 4. 編輯 AGENTS.md，把 [PLACEHOLDER] 換成你的專案資訊
# 5. 建立 FILE_MAP.md（參考 templates/FILE_MAP.template.md）
# 6. 開始使用！
```

---

## 導入後怎麼用？

設定完成後，每次開始新的工作 session，跟 agent 說：

```
讀 AGENTS.md，理解工作流。今天的任務是：[你要做的事]
```

Agent 就會自動採用 **Planner → Executor → Reviewer** 的工作模式：
- 大任務會被拆成小塊，平行處理
- 每個小任務完成後自動跑 build 驗證
- 不會亂建檔案（會先查 FILE_MAP.md）
- 部署後會自動驗證是否成功

---

## Quick Reference

| 我是... | 我該怎麼做 |
|---------|-----------|
| **Claude Code 用戶** | 複製 Option A 的 prompt，貼到對話裡 |
| **Kiro IDE 用戶** | 複製 Option B 的 prompt，貼到對話裡 |
| **想手動控制** | 照 Option C 的步驟操作 |
| **想了解更多** | 讀 [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) |
| **想看範例** | 看 [examples/](./examples/) 資料夾 |

## Directory Structure

```
kiro-agent-starter-kit/
├── AGENTS.md                  # Cross-platform source of truth (所有工具共用)
├── MIGRATION_GUIDE.md         # Adoption guide for existing projects
├── README.md                  # You are here
│
├── kiro/                      # For Kiro IDE users → copy to .kiro/
│   ├── steering/
│   │   ├── subagent-workflow.md
│   │   ├── database-safety.md
│   │   ├── deployment-verification.md
│   │   └── file-placement.md
│   └── hooks/
│       ├── housekeeping.md
│       └── qa-smoke.md
│
├── claude-code/               # For Claude Code users → copy to project root
│   ├── CLAUDE.md
│   └── .claude/
│       └── rules/
│           ├── workflow.md
│           ├── database-safety.md
│           └── deployment-verification.md
│
└── docs/                      # Shared documentation templates
    ├── FILE_MAP_TEMPLATE.md
    └── QA_CHECKLIST.md
```

## Key Concepts

### Sub-Agent Workflow（子代理工作流）

The main context is for **planning only**. All implementation is delegated to sub-agents:

| Role | Responsibility |
|------|---------------|
| **Planner** | Breaks tasks into steps, assigns to executors |
| **Executor** | Implements one focused task, verifies with build |
| **Reviewer** | Checks output quality, runs QA layers |

### 3-Layer QA Strategy（三層品質策略）

| Layer | When | What |
|-------|------|------|
| **Smoke** | After every sub-agent task | Build passes, no type errors, basic functionality |
| **Regression** | After feature complete | Run full test suite, check existing features unbroken |
| **Full Audit** | Before deploy / end of batch | Deep check: edge cases, mobile, accessibility, security |

### Housekeeping Agent（整理代理）

Runs periodically (or on trigger) to:
- Update `audit_log.md` with batch summaries
- Clean up `temporary/` files older than 7 days
- Verify `FILE_MAP.md` matches actual project structure
- Flag TODOs that have been open > 2 weeks

### File Placement Rules（檔案放置規則）

Before creating any new file, agents **must** check `FILE_MAP.md` to determine the correct location. No guessing, no "I'll put it here for now."

### Database Safety（資料庫安全）

- Migrations are **additive only** — never DROP columns/tables without explicit approval
- All migrations go through `temporary/` first for review
- Production data is sacred（正式環境資料神聖不可侵犯）

### Deployment Verification（部署驗證）

`git push` ≠ deployed. After every deploy:
1. Check deployment platform status (Vercel/AWS/Railway)
2. Hit the live URL and verify response
3. Confirm no rollback occurred

## Customization

When adopting this kit, customize these for your project:

| What to Change | Where | Example |
|---------------|-------|---------|
| Build command | AGENTS.md, steering files | `npm run build` → `pnpm build` |
| Test command | QA steering files | `npm test` → `pytest` |
| File structure | FILE_MAP_TEMPLATE.md | Add your app's directories |
| Deploy target | deployment-verification | Vercel → AWS CDK |
| Tech stack | AGENTS.md header | Next.js → Django + HTMX |
| Max parallel agents | AGENTS.md | 3 → 5 (if 32GB+ RAM) |

## Resource Limits

Default configuration assumes:
- **3 parallel sub-agents** (suitable for 16GB RAM machines)
- Adjust in AGENTS.md if your machine has more/less capacity
- Each sub-agent holds ~8K tokens of context

| RAM | Recommended Max Agents |
|-----|----------------------|
| 8GB | 1-2 |
| 16GB | 3 (default) |
| 32GB+ | 4-5 |

## Compatibility

| Tool | Support Level | Notes |
|------|--------------|-------|
| **Kiro IDE** | ✅ Full | Steering files + hooks |
| **Claude Code** | ✅ Full | CLAUDE.md + .claude/rules/ |
| **Claude CoWork** | ✅ Full | Uses AGENTS.md directly |
| **Cursor** | ⚠️ Partial | AGENTS.md works, no hooks |
| **Windsurf** | ⚠️ Partial | AGENTS.md works, no hooks |

## Contributing

This is a living framework. Every time an agent makes a mistake:
1. Identify the root cause
2. Add a rule to prevent recurrence
3. Update AGENTS.md or the relevant steering file

好的規則來自真實的錯誤 — Good rules come from real mistakes.

## License

MIT
