name: bug-report
description: Creates a structured, self-contained bug report with reproduction steps, severity×frequency matrix classification, environment capture, duplicate detection, and suggested fix. Every report must allow someone who has never seen the bug to understand, reproduce, and verify the fix.
allowed-tools: read_file, write_file, search_files, terminal, clarify
model: sonnet
agent: qa-tester

Bug Report — Structured Bug Documentation

This skill creates a persistent, numbered bug report in the project's bug tracking system. Every bug report must be self-contained: someone who has never seen the bug should be able to understand, reproduce, and verify the fix from this document alone.

Output: production/bugs/bug-[N].md

---

Phase 1: Gather Information

Ask the user these questions one at a time. Do not present them as a block.

1a. What happened vs what should have happened?
Ask: "Describe the bug. What actually happened, and what did you expect instead?"
Push for specifics:
- Vague: "The game crashed." → Ask: "When exactly did it crash? What were you doing? Any error message?"
- Acceptable: "Clicked the 'Water' button on the plant. Expected: watering animation + plant grows one stage. Actual: nothing happens. No error message."
- Record both: ACTUAL behavior and EXPECTED behavior.

1b. Steps to reproduce (from clean state)
Ask: "What exact steps lead to this bug? Walk through from a clean launch."
Number the steps. Must be reproducible from a fresh game start.
Example:
1. Launch the game
2. Click 'New Game'
3. Wait for intro scene to finish
4. Click the watering can icon on the plant pot
5. Observe: no animation plays, plant does not grow

If the user gives 1-2 vague steps: ask for more detail. "I need to be able to reproduce this exactly. What happens between step 1 and step 2?"

1c. Frequency
Ask: "How often does this happen?"
Use clarify:
- Always (10/10 attempts) → HIGHEST confidence
- Often (5-9/10) → HIGH confidence
- Sometimes (1-4/10) → MEDIUM confidence, may be environmental
- Rarely (1/20+) → LOW confidence, hardest to debug
- Unknown → User hasn't tested enough to know

If "Rarely" or "Unknown": ask "Can you think of anything special about when it happens? (Different scene, different time of day, different save file?)"

1d. Environment
Read docs/technical-preferences.md for engine version.
Ask: "What platform?"
Options: Windows, macOS, Linux, Web (HTML5), Android, iOS, Console
Also ask: "Build version or git commit?" (If known)
If user doesn't know engine version: note "Environment: engine version not available — check project settings."

---

Phase 2: Classify Severity

Determine severity using the CCGS-standard severity × frequency matrix:

Impact ↓ \ Frequency → | Always | Often | Sometimes | Rarely
Game-breaking (crash, save corruption, can't progress) | CRITICAL | CRITICAL | HIGH | MEDIUM
Feature broken (doesn't work as designed, game is playable) | HIGH | HIGH | MEDIUM | LOW
Cosmetic (visual/audio glitch, wrong text, odd animation) | MEDIUM | MEDIUM | LOW | LOW
Polish (minor imperfection, edge case wording) | LOW | LOW | LOW | LOW

Explain the classification to the user: "Based on [frequency] frequency and [impact] impact, this is [severity]."
Use clarify to confirm: "Does severity [severity] feel right?"
Options: "Yes, that's correct", "No, it's more severe", "No, it's less severe"

If user disagrees: adjust by one tier and confirm again.

---

Phase 3: Check for Duplicates

Search production/bugs/bug-*.md for similar reports.
Look for keywords from the bug description: the system name, the action, the error.
Use search_files(pattern='[keyword]', path='production/bugs/') for each keyword.

If potential duplicates found:
- Read the existing report(s)
- Compare: same reproduction steps? Same error? Same system?
- Present: "Bug [N]: [title] — similar. Is this the same bug?"

If confirmed duplicate:
- Add a note to the existing report: "Also reported on [date] — merged."
- Do NOT create a new file. Stop here.
- Inform user: "This bug is already tracked in bug-[N]. Added a note about the new report."

---

Phase 4: Determine Next Bug Number

List production/bugs/bug-*.md.
Extract the highest N from filenames matching bug-([0-9]+).
Next N = highest + 1 (or 1 if no bugs exist).

---

Phase 5: Write Bug Report

Write to production/bugs/bug-[N].md with this exact structure:

```
# Bug [N]: [Short descriptive title — max 10 words]

**Reported:** [YYYY-MM-DD]
**Severity:** CRITICAL / HIGH / MEDIUM / LOW
**Frequency:** Always / Often / Sometimes / Rarely
**Status:** Open
**Found in:** [version or commit, or "Unknown"]

## Description
[What happened] vs [what should have happened]

## Steps to Reproduce
1. 
2. 
3. 

## Environment
- Platform: [Windows/Mac/Linux/Web/Android/iOS]
- Engine version: [from technical-preferences.md, or "Unknown"]
- Build: [commit hash or build number, or "Unknown"]

## Frequency
[Always / Often / Sometimes / Rarely] — [details of how you determined this]

## Notes
[Any additional context: screenshots, logs, related issues, attempted workarounds]
```

Get user approval: "May I write this to production/bugs/bug-[N].md?"

---

Phase 6: Post-Checks

- Confirm: "Bug report saved to production/bugs/bug-[N].md"
- If CRITICAL: ask "This is a critical bug. Flag it for the current sprint?"
- If fix is known: ask "Would you like me to start implementing the fix?"
- If fix is unknown but severity is HIGH+: ask "Should I investigate the root cause?"

---

Edge Cases

- User can't reproduce consistently: Record as Rarely. Do not reject. Note: "Could not reproduce — may be timing-dependent."
- Bug on unsupported platform: Still file. Note: "Reproduced on [platform] — may be out of scope for supported platforms."
- User gives vague description: Ask up to 3 clarifying questions. If still vague: write what you have, note "Needs clarification — cannot reproduce from current description."
- Same bug filed 3rd time: Merge all. Update report with ALL reproduction methods found.
- User reports feature request as bug: Don't file as bug. Ask: "This sounds like a feature request, not a bug. Should I create a story instead?"
