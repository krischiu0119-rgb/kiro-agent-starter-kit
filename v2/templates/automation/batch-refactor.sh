#!/usr/bin/env bash
# 2026-05-07
# Batch Refactor Script — Claude Code CLI
# Usage: ./batch-refactor.sh "refactoring instruction" [glob-pattern]
#
# Examples:
#   ./batch-refactor.sh "convert all class components to functional components" "src/**/*.tsx"
#   ./batch-refactor.sh "add error boundaries to all page components" "app/**/page.tsx"
#   ./batch-refactor.sh "replace console.log with structured logger" "src/**/*.ts"

set -euo pipefail

# --- Configuration ---
MODEL="${REFACTOR_MODEL:-claude-sonnet-4-5}"  # Tier 2 for implementation
MAX_PARALLEL=3
LOG_DIR="temporary"

# --- Validation ---
if [ $# -lt 1 ]; then
  echo "Usage: $0 \"instruction\" [glob-pattern]"
  echo ""
  echo "Examples:"
  echo "  $0 \"convert class components to hooks\" \"src/**/*.tsx\""
  echo "  $0 \"add input validation to all API routes\" \"app/api/**/*.ts\""
  exit 1
fi

INSTRUCTION="$1"
GLOB_PATTERN="${2:-}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
LOG_FILE="${LOG_DIR}/${TIMESTAMP}-batch-refactor.md"

# --- Setup ---
mkdir -p "$LOG_DIR"

echo "# Batch Refactor Log" > "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "- **Date**: $(date '+%Y-%m-%d %H:%M')" >> "$LOG_FILE"
echo "- **Instruction**: ${INSTRUCTION}" >> "$LOG_FILE"
echo "- **Pattern**: ${GLOB_PATTERN:-all files}" >> "$LOG_FILE"
echo "- **Model**: ${MODEL}" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "## Results" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# --- Build prompt ---
PROMPT="You are performing a batch refactoring task.

Instruction: ${INSTRUCTION}
${GLOB_PATTERN:+File pattern: ${GLOB_PATTERN}}

Rules:
1. Check FILE_MAP.md before creating any new files
2. Make changes incrementally — max ${MAX_PARALLEL} files at a time
3. Run the build command after each batch to verify
4. If build fails, fix immediately before continuing
5. Write a summary of all changes to ${LOG_FILE}
6. Do NOT refactor unrelated code — stay focused on the instruction"

# --- Execute ---
echo "🔄 Starting batch refactor..."
echo "   Model: ${MODEL}"
echo "   Instruction: ${INSTRUCTION}"
echo "   Log: ${LOG_FILE}"
echo ""

claude -p "$PROMPT" \
  --model "$MODEL" \
  --permission-mode auto \
  2>&1 | tee -a "$LOG_FILE"

echo ""
echo "✅ Batch refactor complete. Log: ${LOG_FILE}"
