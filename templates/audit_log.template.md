<!-- 2026-05-05 -->
<!-- TEMPLATE: Copy this file into your project root and rename to audit_log.md -->
<!-- This tracks significant changes made by AI agents for accountability. -->
<!-- Delete all <!-- TEMPLATE comments when done. -->

# Audit Log

<!-- TEMPLATE: How to use this file -->
<!--
- Agents append rows after completing a batch of work (not per-file)
- Each row captures: when, what action, what was affected, and why
- This provides an audit trail for reviewing AI-assisted changes
- Useful for debugging ("when did this break?") and accountability

Column guide:
- Timestamp: YYYY-MM-DD HH:MM (24h format, local time)
- Action: What was done (e.g., fsWrite, strReplace, executeBash, deploy, migration)
- Target: What file/system was affected
- Reason: Brief explanation of why

Tips:
- Group related changes into one row (e.g., "P0 batch | pos/app/, pos/lib/ | 5 bug fixes")
- Use specific file paths for single-file changes
- Use directory paths for multi-file batches
- Add a blank line between work sessions for readability
-->

| Timestamp | Action | Target | Reason |
|-----------|--------|--------|--------|
| [YYYY-MM-DD HH:MM] | Initial setup | Project | Framework adopted |
