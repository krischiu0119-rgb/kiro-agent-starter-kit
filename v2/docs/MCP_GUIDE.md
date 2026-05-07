<!-- 2026-05-07 -->
# MCP Setup Guide

> Model Context Protocol (MCP) connects your agent to external tools. Start with 4 essentials, add more as needed.

---

## Essential Kit (Enable by Default)

These 4 MCPs provide maximum utility with reasonable token cost:

| # | Server | What It Does | Token Cost | Security Notes |
|---|--------|-------------|------------|----------------|
| 1 | **fetch** | Reads web pages, returns markdown | Medium (2-8K/call) | Safe — read-only |
| 2 | **web-search** (Brave) | Internet search with snippets | Low (1-3K/call) | Requires API key |
| 3 | **github** | Repository ops — issues, PRs, code search | Medium (2-10K/call) | Restrict auto-approve to read ops |
| 4 | **Context7** | Library documentation lookup | Medium-High (3-10K/call) | Safe — read-only |

### When to use each

- **fetch**: Reading documentation pages, changelogs, API references
- **web-search**: Finding solutions, checking current info, troubleshooting errors
- **github**: Managing issues/PRs, searching code across repos, reading remote files
- **Context7**: Getting accurate, up-to-date library docs (avoids hallucinated APIs)

---

## Optional Add-ons (Disabled by Default)

Enable per-project based on your needs:

| Server | Enable When | Token Cost | Security Notes |
|--------|------------|------------|----------------|
| **google-sheets** | Project involves spreadsheet data | High (5-20K+/call) | Needs Google credentials; restrict to read ops initially |
| **playwright** | Doing E2E testing or web scraping | Very High (10-30K+/call) | Never auto-approve `browser_run_code_unsafe`; restrict to safe navigation actions |
| **aws-knowledge-mcp** | Building on AWS infrastructure | Medium-High (5-15K/call) | Safe — read-only AWS docs |

---

## Configuration

### Template location

See `templates/mcp.template.json` for the complete starter configuration.

### Environment variables needed

```bash
# Required for essential kit
export BRAVE_API_KEY="your-brave-search-api-key"
export GITHUB_PAT="your-github-personal-access-token"
export CONTEXT7_API_KEY="your-context7-api-key"

# Optional (only if enabling add-ons)
export GOOGLE_SHEETS_CREDENTIALS_PATH="/path/to/credentials.json"
```

### Where to get API keys

| Key | Source | Free Tier |
|-----|--------|-----------|
| `BRAVE_API_KEY` | [brave.com/search/api](https://brave.com/search/api/) | 2,000 queries/month |
| `GITHUB_PAT` | GitHub Settings → Developer Settings → Personal Access Tokens | Unlimited (rate-limited) |
| `CONTEXT7_API_KEY` | [context7.com](https://context7.com) | Check current plans |

---

## Auto-Approve Best Practices

Auto-approve lets the agent use MCP tools without asking permission each time. Be selective:

**Safe to auto-approve (read-only):**
- `fetch` — reading web pages
- `brave_web_search` — searching the internet
- `resolve-library-id`, `get-library-docs`, `query-docs` — Context7 lookups
- `get_file_contents`, `search_repositories`, `search_code` — GitHub reads
- `list_issues`, `list_pull_requests` — GitHub listing

**Require manual approval (write operations):**
- `create_repository` — prevents accidental repo creation
- `create_pull_request` — you want to review PR content first
- `push_files` — writing to remote repos
- `browser_run_code_unsafe` — arbitrary code execution in browser
- Any Google Sheets write operations on first use

**Rule of thumb:** Auto-approve reads, manually approve writes.

---

## How to Add/Remove MCPs

### Adding a new MCP

1. Find the MCP on [registry.modelcontextprotocol.io](https://registry.modelcontextprotocol.io) or [mcphub.io](https://mcphub.io)
2. Add its configuration to your `mcp.json`
3. Set `"disabled": false` to enable
4. Configure `autoApprove` with only safe (read) operations
5. Test with a simple query to verify it works

### Removing an MCP

Option A: Set `"disabled": true` (keeps config, stops loading)
Option B: Delete the entry from `mcp.json` entirely

### Config file locations

- **Claude Code**: `~/.claude/mcp.json` (global) or `.claude/mcp.json` (project)
- **Kiro**: `~/.kiro/settings/mcp.json` (global) or `.kiro/mcp.json` (project)

---

## Token Cost Tiers

| Tier | MCPs | Typical Cost/Call | Recommendation |
|------|------|-------------------|----------------|
| Low | web-search | 1-3K tokens | Always enable |
| Medium | fetch, github, Context7 | 2-10K tokens | Always enable |
| High | google-sheets, aws-knowledge | 5-20K tokens | Enable per-project |
| Very High | playwright | 10-30K+ tokens | Enable only during UI testing |

**Budget tip:** If you're hitting context limits, disable playwright and google-sheets first — they consume the most tokens per call.

---

## Recommended Claude Code Plugins

These plugins extend Claude Code's capabilities. Install via `/plugin` command in Claude Code.

### Recommended (add to your workflow)

| Plugin | Install Command | What It Does | Why |
|--------|----------------|-------------|-----|
| **context-mode** | `/plugin marketplace add mksglu/context-mode` then `/plugin install context-mode@context-mode` | Sandboxes tool output, saves 94-98% context window | Prevents MCP responses from eating your 200K context |
| **claude-mem** | `/plugin marketplace add thedotmack/claude-mem` then `/plugin install claude-mem` | Auto-captures session history, compresses with AI, injects into future sessions | Solves context loss between sessions |
| **skill-creator** | `/plugin install skill-creator@claude-plugins-official` | Create custom reusable skills within Claude Code | Package your team's workflows as installable skills |

### Alternatives (overlap with this starter kit — choose one approach)

| Plugin | Install Command | What It Does | Overlap With |
|--------|----------------|-------------|-------------|
| **superpowers** (obra) | `/plugin marketplace add obra/superpowers-marketplace` then `/plugin install superpowers@superpowers-marketplace` | Planning mode, TDD, debugging, sub-agent routing, brainstorm | Our `workflow.md` + `core.md` task routing |
| **get-shit-done-cc** | `npx get-shit-done-cc --claude --global` | Meta-prompting + spec-driven development, solves context rot | Our spec-driven workflow + token optimization |
| **frontend-design** | `/plugin install frontend-design@claude-plugins-official` | Frontend design skills and patterns | Project-specific — enable if doing UI work |

### Notes

- **context-mode + our starter kit** = best combo. Context-mode handles token compression at the tool level; our rules handle behavioral structure.
- **superpowers vs our starter kit**: Choose one. Using both will create conflicting task routing rules. Superpowers is more opinionated; our kit is more customizable.
- **claude-mem** complements our `capture-decisions` hook — claude-mem captures everything automatically; our hook captures only rule-worthy decisions.
- All plugins are Claude Code only (not available in Kiro IDE).

### How to Install

```bash
# In Claude Code session:
/plugin marketplace add mksglu/context-mode
/plugin install context-mode@context-mode

/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

/plugin install skill-creator@claude-plugins-official
```

---

## Related

- [templates/mcp.template.json](../templates/mcp.template.json) — Ready-to-use config
- [TOKEN_BUDGET.md](./TOKEN_BUDGET.md) — Understanding token costs
- [FUTURE_ROADMAP.md](../FUTURE_ROADMAP.md) — Progressive MCP Disclosure plans
