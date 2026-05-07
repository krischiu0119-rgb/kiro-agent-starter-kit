#!/usr/bin/env bash
# 2026-05-07
# CI/CD PR Review Script — Claude Code CLI
# Usage: ./ci-review.sh [pr-number]
#
# Designed to run in CI pipelines (GitHub Actions, GitLab CI, etc.)
# Posts review comments directly on the PR.
#
# Environment variables:
#   REVIEW_MODEL    — Model to use (default: claude-opus-4-6 for quality review)
#   GITHUB_TOKEN    — GitHub token for PR comments (usually provided by CI)
#   PR_NUMBER       — PR number (auto-detected in GitHub Actions)

set -euo pipefail

# --- Configuration ---
MODEL="${REVIEW_MODEL:-claude-opus-4-6}"  # Tier 1 for review quality
PR="${1:-${PR_NUMBER:-}}"

# --- Validation ---
if [ -z "$PR" ]; then
  echo "Error: No PR number provided."
  echo "Usage: $0 <pr-number>"
  echo "Or set PR_NUMBER environment variable."
  exit 1
fi

# --- Build prompt ---
PROMPT="You are reviewing PR #${PR}. Perform a thorough code review.

Check for:
1. Security issues (injection, auth bypass, data exposure)
2. Performance problems (N+1 queries, missing indexes, memory leaks)
3. Logic errors (off-by-one, null handling, race conditions)
4. Style consistency with existing codebase
5. Missing error handling or edge cases
6. Breaking changes to public APIs

Output format:
- Start with a 1-line summary (APPROVE / REQUEST_CHANGES / COMMENT)
- List issues by severity (Critical > Warning > Suggestion)
- For each issue: file, line, description, suggested fix
- End with overall assessment

Be constructive. Praise good patterns. Only flag real issues."

echo "🔍 Reviewing PR #${PR}..."
echo "   Model: ${MODEL}"
echo ""

# --- Execute review ---
REVIEW_OUTPUT=$(claude -p "$PROMPT" \
  --model "$MODEL" \
  --permission-mode auto \
  2>&1)

echo "$REVIEW_OUTPUT"

# --- Post to PR (if in CI with GitHub token) ---
if [ -n "${GITHUB_TOKEN:-}" ] && command -v gh &> /dev/null; then
  echo ""
  echo "📝 Posting review to PR #${PR}..."
  gh pr comment "$PR" --body "## 🤖 AI Code Review

${REVIEW_OUTPUT}

---
*Reviewed by Claude (${MODEL}) via ci-review.sh*"
  echo "✅ Review posted."
else
  echo ""
  echo "ℹ️  No GITHUB_TOKEN or gh CLI found. Review printed above only."
  echo "   To post to PR: export GITHUB_TOKEN and install gh CLI."
fi
