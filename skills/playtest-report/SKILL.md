name: playtest-report
description: Documents a structured playtesting session with defined goals, timestamped observations, verbatim player feedback, bug capture, and actionable recommendations. Tracks session count to meet the Phase 6 requirement of 3+ playtest sessions.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: qa-lead

Playtest Report — Structured Player Testing

Creates a permanent record of a playtesting session. The goal is to capture what happened, what the player experienced, and what needs to change — in enough detail that someone who wasn't there can understand the findings.

Three types of playtest are recognized (Phase 6 requirement):
- New player experience (Session 1) — can someone figure out the game?
- Mid-game systems (Session 2) — do systems hold up after the first hour?
- Balance & difficulty (Session 3) — is challenge scaling appropriate?

Output: production/playtests/report-[N].md

---

Phase 1: Determine Session Context

Count existing playtest reports: search_files(pattern='report-*.md', path='production/playtests/')
Next report number = count + 1 (or 1 if none exist).

Ask the user:
1a. "What type of playtest is this?"
Use clarify:
- New player experience — first-time player, no guidance
- Mid-game systems — player familiar with basics, testing depth
- Balance & difficulty — testing progression curves and challenge
- Feature-specific — testing one new system
- Regression — re-testing after changes
- Ad-hoc — unstructured exploration

1b. "Who is the player?"
Record: identity (friend, tester, yourself, anonymous), relationship to project (first time, experienced, developer)

1c. "What's the focus area?"
Ask: "Any specific system, screen, or mechanic we're watching for?"
If unsure: "General gameplay — observe everything."

1d. "What session number is this?"
If this is Session 3 and review mode is not solo: "This meets the Phase 6 requirement for 3 playtest sessions. Gate check criteria satisfied."

---

Phase 2: Define Session Goals

Ask: "What 2-4 questions do we want this session to answer?"
Good questions are specific and observable:
- "Can a new player complete the tutorial without any instructions?"
- "Does the player notice the watering can icon?"
- "Does the player feel resource pressure by minute 15?"
- "Is the first plant growth stage satisfying?"

Bad questions:
- "Is the game fun?" (too vague)
- "Does the code work?" (developer concern, not playtest)
- "Will they like it?" (can't observe directly — infer from behavior)

Write the goals down before the session starts.

---

Phase 3: During-Session Capture (Observer Mode)

If observing the session (user plays while you watch), capture:

3a. Timestamped observations
Record the time and what happened at that moment:
- 0:00 — Player launched game
- 0:15 — Player clicked the plant pot immediately (intuition working?)
- 1:30 — Player hesitates for 5 seconds (confusion at what to do next)
- 3:00 — Player says "Oh, that's cool!" (positive reaction)

Signals to watch for:
- Hesitation (>3 seconds idle) → possible confusion point
- Wrong action → UI or tutorial failure
- Repeated same action expecting different result → misunderstanding
- Positive verbal reaction → note what caused it
- Negative verbal reaction → note what caused it
- Looking around / searching → missing information
- Skipping content → not engaged

3b. Player quotes (verbatim)
Capture exact player words in quotation marks. These are GOLD for understanding their mental model.
- "I thought clicking the pot would show me what's inside."
- "Oh wait, I see the water icon now. It was hidden."
- "This is relaxing. I like that there's no timer."

3c. Bugs encountered
For each bug, note: what happened, where, and how to reproduce.
Severity can be classified later (after the session).

If you CANNOT observe (self-play or remote): skip to Phase 4.

---

Phase 4: Post-Session Debrief

Ask the player (or user) these questions. Record verbatim answers:

1. "What did you do first?"
   (Reveals whether the intended first action matches actual first action)

2. "Was anything confusing or frustrating?
   (Probe for specifics: what exactly was confusing, and what did you expect to happen?)

3. "What was the most fun moment?"
   (Identifies what's working — double down on this)

4. "What was the least fun moment?"
   (Identifies what's broken — prioritize fixing this)

5. "Would you play this again? Why or why not?"
   (Core loop validation — if no, the loop needs work)

6. "One thing to improve:"
   (Prioritized feedback — this is the #1 issue)

---

Phase 5: Write Report

Write to production/playtests/report-[N].md:

```
# Playtest Report [N]: [Focus Area]

**Date:** [YYYY-MM-DD]
**Playtester:** [identity]
**Session type:** [type]
**Session #:** [N]/3 (for polish phase)
**Build:** [version or commit]

## Session Goals
1. [Goal 1]
2. [Goal 2]

## Observations
[Timestamped notes from the session]
- [0:00] [observation]
- [1:30] [observation]

## Player Feedback
[Verbatim or summarized feedback]
- "Quote 1"
- "Quote 2"

## Bugs Found
- [ ] [Brief description] — Severity: [CRIT/HIGH/MED/LOW]
- [ ] [Brief description] — Severity: [CRIT/HIGH/MED/LOW]

## What Worked
- [Element that succeeded and why]

## What Didn't Work
- [Element that failed and why]

## Recommendations
1. [Actionable change — what, where, why]
2. [Actionable change]

## Session Stats
- Duration: [minutes]
- Progression reached: [what the player achieved/accomplished]
- Confusion moments: [count]
- Positive reactions: [count]
- Bugs found: [count]
```

Get user approval before writing.

---

Phase 6: Post-Checks

- If bugs were found: "I found [N] bugs in the report. Would you like to file formal bug reports for them?"
- If recommendations are actionable: "The recommendations are clear. Should I create stories for any of these?"
- If this is Session 3/3 for polish phase: "All 3 playtest sessions complete. This satisfies the Phase 6 gate requirement."
- If no bugs and positive feedback: "No significant issues found. Consider moving to the next phase."
