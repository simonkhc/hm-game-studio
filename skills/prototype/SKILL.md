name: prototype
description: Structured prototyping to validate a design hypothesis. Two modes: concept prototype (Phase 1, quick-and-dirty, hours) and vertical slice (Phase 4, production-quality, days). For each: define hypothesis, set constraints (time, scope, anti-scope), build, evaluate, write report with PROCEED/PIVOT/KILL verdict.
allowed-tools: read_file, write_file, terminal, clarify, delegate_task
model: sonnet
agent: prototyper

Prototype — Rapid Hypothesis Validation

Runs a structured prototyping process. The goal is not production code — it's to answer a specific design question as quickly as possible.

Two modes, different standards:
- Concept prototype (Phase 1): Validates a single mechanic. Hours. Code quality irrelevant.
- Vertical slice (Phase 4): Validates the entire core loop. Days. Production-quality architecture.

Output: prototypes/[name]/ + prototype-report.md + (verdict file)

---

Phase 1: Select Mode

Ask: "What kind of prototype are we building?"
Use clarify:
1. Concept prototype — test a single mechanic, throwaway code, hours not days
2. Vertical slice — prove the full core loop works, production architecture, days to weeks

If the user is in Phase 1 (Concept): default to concept prototype.
If the user is in Phase 4 (Pre-Production): default to vertical slice.
If unsure: concept prototype. "Start small. You can always expand to a vertical slice later."

---

Phase 2: Form Hypothesis

The hypothesis must be SPECIFIC and TESTABLE.
Ask: "What specifically are we testing? What do we expect to happen?"

Good hypothesis: "I think clicking a plant and seeing it grow within 200ms will feel satisfying. If 8/10 testers say it's 'responsive' or better, we keep this approach."
Bad hypothesis: "I want to test if the game is fun."

Push vague hypotheses into concrete form:
- "Test if the game is fun" → "What specifically makes the game fun? The growth mechanic? The anticipation? The visuals? Pick ONE."
- "Test the combat" → "Which part of combat? Hit detection? Damage numbers? Enemy AI? Pick ONE."

Format: "I think [action] will result in [observable outcome]. If [measurement] is above/ below [threshold], we [proceed / pivot / kill]."

Write hypothesis to prototypes/[name]/HYPOTHESIS.md BEFORE any code is written.

---

Phase 3: Set Constraints

Ask three questions:

3a. "Time limit?"
- Concept prototype: 2-6 hours. Set a hard stop.
- Vertical slice: 2-5 days. Set a hard stop.
If the user says "however long it takes": push back. "Without a time limit, a prototype becomes production. Set a deadline."

3b. "Minimum scope?"
"What is the absolute minimum we need to build to test the hypothesis?"
Strip everything else. The prototype should be the smallest possible thing that answers the question.

3c. "Anti-scope?"
"What are we explicitly NOT building?"
Examples: "No save/load. No settings screen. No audio. No menu. No tutorial. Only one level."
Anti-scope is critical — it prevents scope creep during the prototype.

Write constraints to prototypes/[name]/CONSTRAINTS.md.

---

Phase 4: Build

Build the prototype. Standards depend on mode:

Concept prototype rules:
- Fastest path to working mechanic. Copy-paste is OK.
- Hardcoded values are OK (no config files needed).
- No error handling. (The prototype can crash — you're testing the mechanic, not the stability.)
- No tests. (Delete after evaluation.)
- Single file if possible.
- If 50% of time has passed and it's not working: timebox expires. Evaluate what you have. Do not keep building.

Vertical slice rules:
- Real architecture. No throwaway code. Every line should be production-quality.
- Config files for tunable values.
- Real naming conventions.
- One complete [start → play → resolution] cycle.
- Minimal placeholder art (functional, not pretty).
- Tests for the core logic.

For both modes: propose approach → get approval → write → test. Do not code without approval.

---

Phase 5: Evaluate

When the time limit is reached (or when working prototype is done), evaluate:

Ask these questions IN ORDER:
1. "Does the mechanic feel how we expected?"
   (Compare against the hypothesis. Not "is it good" — "does it match the prediction?")

2. "Did anything surprising happen?"
   (Unexpected results are often more valuable than expected ones.)

3. "What would need to change for production?"
   (If PROCEED: what's the migration path from prototype to real code?)

4. "Should we proceed, pivot, or kill?"
   Use clarify:
   - PROCEED: The hypothesis is validated. Move to production planning.
   - PIVOT: The mechanic works but needs significant changes. Try a different approach.
   - KILL: The hypothesis is invalid. Don't invest more time in this direction.

---

Phase 6: Write Report

Write to prototypes/[name]/prototype-report.md:

```
# Prototype Report: [Name]

**Date:** [date]
**Mode:** Concept / Vertical Slice
**Build time:** [hours/days] (vs [time limit] planned)

## Hypothesis
[Original hypothesis from HYPOTHESIS.md]

## Verdict
PROCEED / PIVOT / KILL

## What We Learned
- [Key finding 1 — specific, actionable]
- [Key finding 2]

## What Changed
- [Design changes that resulted from this prototype]
- [If nothing changed: "Design unchanged — hypothesis confirmed as-is"]

## Migration Path (if PROCEED)
- [What code can be kept? What must be rewritten?]
- [What's the estimated effort for production version?]

## Next Steps
- [If PROCEED: next milestone or sprint story]
- [If PIVOT: what alternative to try and how]
- [If KILL: rationale and alternative direction]
```

---

Phase 7: Post-Checks

- Hypothesis was documented BEFORE building? (Check HYPOTHESIS.md timestamp vs code files.)
- Verdict is clearly stated. No "maybe" or "let's see".
- Next steps are defined. Even for KILL — "stop working on this" is a valid next step.
- If PROCEED: create stories for the production work.
- If KILL: update systems-index.md to remove the killed system.

---

Edge Cases

- Prototype proves nothing because it's too buggy: "The prototype didn't work well enough to test the hypothesis. That's a finding too — the mechanic may be too complex to prototype in [time limit] hours."
- User wants to keep building past deadline: Stop them. "The time limit was [N] hours. Extending it turns this into production. What's your call — stop or officially extend?"
- Prototype works but isn't fun: This is the most common result. "It works but it's not fun yet. That means the implementation is right but the design needs iteration. Should we PIVOT the design or KILL the concept?"
