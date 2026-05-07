---
# 2026-05-07
description: Rules for executing code safely — complex code goes to files, simple commands inline.
inclusion: auto
---

<!-- 2026-05-07 -->

# Code Execution

## Core Rule
Complex code → create file, then run. Simple commands → inline OK.

## Process
1. Ensure `[TEMP_DIR]/` exists
2. Create file: `[TEMP_DIR]/YYYYMMDD-description.ext`
3. Run with appropriate interpreter

## What's "Complex"
File required: JSON parsing, multi-step ops, API calls, loops/conditionals, data transforms.
Inline OK: ls, cat, grep, version checks, simple curl, env checks.

## Naming
`YYYYMMDD-description.ext` — always date-prefixed for easy cleanup.
