name: tech-debt
description: Log and track technical debt with file paths, severity (LOW/MEDIUM/HIGH), category (architecture/performance/maintainability/standards), and age. Scans codebase for common debt patterns: hardcoded values, dead code, TODO/FIXME markers, large files. Maintains a persistent register in docs/tech-debt-register.md. Offers to fix HIGH items immediately.
allowed-tools: read_file, search_files, write_file, patch, clarify
model: sonnet
agent: lead-programmer

Tech Debt — Technical Debt Register

Identifies, classifies, and tracks technical debt items in the codebase.
Maintains a persistent register that is updated each time this skill runs.

Output: docs/tech-debt-register.md (created or updated)

---

Phase 1: Scan for Common Debt Patterns

1a. Hardcoded values (if data-driven rule applies)
Search src/ for numeric literals that aren't obviously safe (0, 1, -1, 100):
- search_files(pattern='[0-9]{2,}', path='src/', file_glob='*.gd') or equivalent
- For each found: is it a tunable value? (gameplay value → should be config)
- If yes: "Hardcoded [value] at [file:line]. Should be in config file."
- Skip: 0, 1, -1, 100, engine constants, array indices, math constants (PI, etc.)

1b. Dead code
Search for commented-out code blocks: patterns like "/* ... */" or "# old code" or "// deprecated"
- If found: "Dead code at [file:line]. Remove or uncomment with explanation."
- Check for unused functions: search for function definitions that are never called

1c. TODO/FIXME/HACK/XXX markers
Search src/ for "TODO", "FIXME", "HACK", "XXX", "TEMP", "WORKAROUND", "HACK"
- Categorize each:
  - HIGH: FIXME in production code, security concern, data loss risk
  - MEDIUM: TODO for important feature, known limitation
  - LOW: TODO for minor cleanup, style improvement

1d. Large files
Read all source files. Flag any file > 500 lines.
- 500-1000 lines: MEDIUM — consider splitting
- 1000+ lines: HIGH — should be refactored
- List: file path, line count, what the file does

---

Phase 2: Classify Each Item

For each item found, assign:
- Severity: HIGH (blocks work) / MEDIUM (slows work) / LOW (cosmetic)
- Category: Architecture / Performance / Maintainability / Standards
- Location: exact file path and line number
- Description: one sentence explaining what it is
- Age: if the item was already in the register, use its original date. Otherwise, today.

---

Phase 3: Update Register

Check if docs/tech-debt-register.md exists.
Read existing entries. Do NOT delete old entries — only add new ones and update statuses.

For each new item found: add a row to the register table.
For each existing item that was FIXED since last scan: update its status to "Fixed" with the date.
For each existing item still present: leave as-is. If the severity changed, update.

Register format:
```
| ID | Severity | Category | File | Description | Date | Status |
| TD-001 | HIGH | Maintainability | src/gameplay/plants.gd:142 | Hardcoded growth_rate (7) | 2026-06-01 | Open |
```

---

Phase 4: Offer Fixes

For HIGH severity items: "Found [N] HIGH priority tech debt items. Should I fix them now?"
- If yes: fix each one (use patch to move value to config, remove dead code, resolve TODOs)
- If no: "Logged to register. Schedule for next sprint."

For items that are fixable in <5 minutes: offer to fix immediately.
For items requiring significant refactoring: "This needs a story, not a quick fix. I'll create a tech debt story."

---

Edge Cases

- No tech debt found: "No significant tech debt detected. Run again after adding more code."
- Register is getting long (>50 items): "Register has [N] items. Consider a tech debt sprint to pay down the backlog."
- Same item found across multiple scans: Keep the oldest date. Update severity if it changed.

---

Phase 5: Trend Analysis

If previous tech debt register exists:
- Count Open items trend: "Tech debt went from [N] to [M] since last scan."
- Age of oldest Open item: "Oldest debt is [N] days old — [description] from [file]."
- High/Critical items: [N] unchanged / [N] new / [N] resolved
- If increasing: "Debt is accumulating faster than it's being resolved. Consider dedicating 20% of each sprint to debt."

---

Phase 6: Categorization Summary

Present a summary of debt by category:
- Architecture: [N] items — these will get worse over time
- Performance: [N] items — may not matter yet but will at scale
- Maintainability: [N] items — slowing down development now
- Standards: [N] items — consistency issues, low impact

If Architecture debt > 30% of total: "Architecture debt is the most expensive to fix later. Prioritize these."

---

Phase 7: Recommendations

Based on the scan, recommend:
1. "Fix [HIGH item] now — it's blocking [story/work]"
2. "Schedule [MEDIUM item] in next sprint — it's slowing development on [system]"
3. "Track [LOW items] — not urgent but should be addressed eventually"

If any item is both HIGH and <5 min to fix: offer to fix it immediately in the conversation.
"Hardcoded value at [file:line] — this takes 2 minutes to move to config. Fix it now?"

---

Edge Cases

- No source code in src/: "No code to scan. Run after implementing at least one system."
- Register file is corrupted: Back up and recreate from scratch. "Register file was unreadable. Created fresh backup at docs/tech-debt-register.md.bak"
- User wants to delete the entire register: "I can't recommend that. Debt that isn't tracked will still cause problems, just without warning. Archive instead."
