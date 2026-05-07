#!/usr/bin/env bash
# 2026-05-07
# Scheduled Code Audit Script — Claude Code CLI
# Usage: ./scheduled-audit.sh [audit-type]
#
# Audit types:
#   security    — Check for vulnerabilities, exposed secrets, auth issues
#   quality     — Check for code smells, dead code, complexity
#   deps        — Check for outdated/vulnerable dependencies
#   full        — All of the above
#
# Designed to run on a schedule (cron, GitHub Actions schedule, Claude Routines)
#
# Environment variables:
#   AUDIT_MODEL     — Model to use (default: claude-haiku-4-5 for cost efficiency)
#   AUDIT_OUTPUT    — Output directory (default: temporary/)

set -euo pipefail

# --- Configuration ---
MODEL="${AUDIT_MODEL:-claude-haiku-4-5}"  # Tier 3 for cost-efficient scanning
OUTPUT_DIR="${AUDIT_OUTPUT:-temporary}"
AUDIT_TYPE="${1:-full}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT_FILE="${OUTPUT_DIR}/${TIMESTAMP}-audit-${AUDIT_TYPE}.md"

# --- Validation ---
case "$AUDIT_TYPE" in
  security|quality|deps|full) ;;
  *)
    echo "Error: Unknown audit type '${AUDIT_TYPE}'"
    echo "Valid types: security, quality, deps, full"
    exit 1
    ;;
esac

# --- Setup ---
mkdir -p "$OUTPUT_DIR"

# --- Build prompts per audit type ---
SECURITY_PROMPT="Scan the codebase for security issues:
1. Hardcoded secrets, API keys, passwords
2. SQL injection vulnerabilities
3. Missing input validation
4. Insecure authentication patterns
5. Exposed sensitive data in logs or responses
6. Missing CSRF/XSS protections"

QUALITY_PROMPT="Scan the codebase for quality issues:
1. Dead code (unused functions, unreachable branches)
2. Functions over 50 lines (complexity)
3. Duplicated logic (DRY violations)
4. Missing error handling (unhandled promises, empty catches)
5. TODO/FIXME/HACK comments older than 30 days
6. Inconsistent naming conventions"

DEPS_PROMPT="Check project dependencies:
1. List all dependencies with their current versions
2. Identify any with known vulnerabilities (check CVE databases)
3. Flag dependencies that are 2+ major versions behind
4. Identify unused dependencies (installed but not imported)
5. Check for dependency conflicts or peer dependency warnings"

# --- Compose final prompt ---
case "$AUDIT_TYPE" in
  security) PROMPT="$SECURITY_PROMPT" ;;
  quality)  PROMPT="$QUALITY_PROMPT" ;;
  deps)     PROMPT="$DEPS_PROMPT" ;;
  full)     PROMPT="${SECURITY_PROMPT}

${QUALITY_PROMPT}

${DEPS_PROMPT}" ;;
esac

FULL_PROMPT="You are performing a scheduled code audit (type: ${AUDIT_TYPE}).

${PROMPT}

Output format:
- Write results to: ${REPORT_FILE}
- Use markdown with severity headers: ## Critical, ## Warning, ## Info
- For each finding: file path, line number (if applicable), description, suggested fix
- End with a summary count: X critical, Y warnings, Z info
- If no issues found in a category, say 'None found ✅'"

# --- Execute ---
echo "🔍 Running ${AUDIT_TYPE} audit..."
echo "   Model: ${MODEL}"
echo "   Output: ${REPORT_FILE}"
echo ""

claude -p "$FULL_PROMPT" \
  --model "$MODEL" \
  --permission-mode auto \
  2>&1

echo ""
echo "✅ Audit complete. Report: ${REPORT_FILE}"

# --- Summary ---
if [ -f "$REPORT_FILE" ]; then
  echo ""
  echo "--- Summary ---"
  grep -c "## Critical" "$REPORT_FILE" 2>/dev/null && echo "Critical issues found!" || echo "No critical issues."
fi
