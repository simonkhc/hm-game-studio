name: design-system
description: Create or update a Game Design Document for a specific system, using the 8-section GDD template. Walks through each section interactively with question → options → decide → draft → write. Writes each section to file immediately after approval to survive session interruptions.
allowed-tools: read_file, write_file, search_files, patch, clarify
model: sonnet
agent: systems-designer

Design System — GDD Authoring

Creates a complete GDD (Game Design Document) for a single game system.
Follows the 8-section template from hm-game-studio/templates/GDD-template.md.

Process per section: question → present context → draft → get approval → write immediately.
This incremental write pattern ensures work survives context compaction or session crashes.

Output: design/gdd/[system-name].md

---

Pre-Checks

Before starting, verify:
- design/gdd/game-concept.md exists (pillars reference)
- design/gdd/systems-index.md exists (dependency ordering)
- The system name doesn't collide with an existing GDD (search design/gdd/[name].md)

If game-concept.md doesn't exist, stop and suggest: "No concept doc found. Run start or brainstorm first."
If a GDD already exists for this system, ask: "A GDD for [system] already exists. Do you want to overwrite it, or use quick-design for a smaller change?"

---

Step 1: Read Context

Read design/gdd/game-concept.md — extract pillars, core loop, and MDA targets.
Read design/gdd/systems-index.md — find the system's dependencies and priority.
Read any upstream GDDs (systems this one depends on) for interface/API context.
Read the GDD template at hm-game-studio/templates/GDD-template.md as structural reference.
Read docs/technical-preferences.md for engine and naming conventions.

Step 2: Pre-Check — Technical Feasibility

Before writing content, run a brief feasibility check:
1. Domain mapping: what domain does this system belong to? (gameplay, economy, narrative, etc.)
   If this is the first system in its domain, note: "This is the first [domain] system — no established patterns yet."
2. Feasibility brief: is this achievable within known constraints?
   Check: does the system require any technology the engine doesn't support? (e.g., destructible terrain in a 2D pixel art game)
3. Dependency check: are upstream systems already designed?
   If a dependency GDD doesn't exist, flag: "Depends on [system] which hasn't been designed yet. Recommend designing [system] first."

Step 3: Create Skeleton

Before filling any section, create the file with all section headers:

```
# GDD: [System Name]

**Status:** In Design
**Version:** 0.1

## 1. Overview
## 2. Player Fantasy
## 3. Detailed Rules
## 4. Formulas
## 5. Edge Cases
## 6. Dependencies
## 7. Tuning Knobs
## 8. Acceptance Criteria
```

This ensures progress survives session interruptions. Write it immediately without asking. (A skeleton is not content — it's scaffolding.)

Step 4: Author Section 1 — Overview

Ask the user: "In one paragraph, what does this system do?"
Guide: "Think of this as the elevator pitch for this system. It should tell another designer exactly what this system is for, without any implementation details."

Draft the overview. Read it back to the user.
Ask: "May I write this section to design/gdd/[system-name].md?"
On approval: use patch to replace the "## 1. Overview" placeholder with actual content.

Step 5: Author Section 2 — Player Fantasy

Ask the user: "When the player uses this system, what should they FEEL?"
Guide with examples:
- Good: "The player feels like a master gardener — they look at their plants and feel pride in what they've grown."
- Bad: "The player can water plants."
- Too abstract: "The player feels engaged."

If the user gives a mechanical description instead of a feeling, push back: "That's a rule, not a fantasy. What emotion should the player experience?"

Draft, get approval, write.

Step 6: Author Section 3 — Detailed Rules

Ask the user: "What are the specific rules of this system? Be unambiguous."

For each rule:
- Is it specific? ("Plants grow one stage per 7 days" ✓ vs "Plants grow over time" ✗)
- Is it testable? ("If player waters the plant, growth timer resets" ✓ vs "The plant responds to care" ✗)
- Are exceptions stated? ("All plants follow this rule EXCEPT cacti, which grow in any season")

Keep asking: "Any more rules?" until the user says no.

Organize rules into numbered list for clarity.
Draft, get approval, write.

Step 7: Author Section 4 — Formulas

Ask the user: "What calculations does this system need?"

For each formula, define:
- Variable name and what it represents
- Default value and valid range
- The formula itself (using math notation)
- An example calculation

Example:
```
growth_rate = base_rate * season_multiplier * water_multiplier
base_rate = 1.0 (range: 0.5-2.0) — how fast plants grow by default
season_multiplier = 1.5 for spring, 1.0 for summer, 0.5 for autumn, 0.0 for winter
water_multiplier = 2.0 if watered today, 1.0 if watered this week, 0.5 if never watered

Example: A rose (base_rate=1.0) in spring (season=1.5) that was watered today (water=2.0)
  growth_rate = 1.0 * 1.5 * 2.0 = 3.0
```

If the user says "I don't know the formula yet": Accept that and write a placeholder.
Flag: "FORMULA NEEDED" in the section for later tuning.

Draft, get approval, write.

Step 8: Author Section 5 — Edge Cases

Ask the user: "What weird situations could happen with this system?"

Probe with specific scenarios:
- "What if the player does nothing?" (default state)
- "What if the player does the opposite of what's expected?"
- "What if two things happen at the same time?" (race condition)
- "What if the player inputs invalid data?"
- "What if the system receives data from a not-yet-designed system?"

For each edge case, record:
- The situation
- The expected behavior
- The error state (if any)

If the user says "that can't happen": Document it anyway. "Player edits save file to set date to year 2099 — what happens?"

Draft, get approval, write.

Step 9: Author Section 6 — Dependencies

Ask the user: "What other systems does this system need to work?"
For each dependency:
- System name (must match systems-index.md)
- What data/functions it needs from that system
- Whether it's REQUIRED or OPTIONAL

Then ask: "What other systems need this system?"
List downstream dependents (even if their GDDs don't exist yet).

Cross-check with systems-index.md: do the bidirectional references match?
If GDD-A says it depends on B, but B's GDD (or the index) doesn't list A as a dependent, flag: "MISSING BIDIRECTIONAL REFERENCE — B should list A."

Draft, get approval, write.

Step 10: Author Section 7 — Tuning Knobs

Ask the user: "What values should designers be able to change without touching code?"

For each tuning knob:
- Parameter name
- Default value
- Valid range (min, max, step)
- What happens at min boundary
- What happens at max boundary
- Config file path (should be assets/data/[system].json or equivalent)

Examples:
| Parameter | Default | Range | Step | Config file |
| growth_rate | 1.0 | 0.1-5.0 | 0.1 | assets/data/garden.json |
| max_plants | 10 | 1-100 | 1 | assets/data/garden.json |

If the user says "this should never change": Move it to Tuning Knobs anyway. "Every constant is a tuning knob until the game ships. It's easier to have it configurable and not need it, than to need it and have it hardcoded."

Draft, get approval, write.

Step 11: Author Section 8 — Acceptance Criteria

Ask the user: "How do we know when this system is working correctly?"

For each criterion:
- Must be testable (verifiable PASS/FAIL)
- Must be specific ("Plant grows from seed to sprout in 7 days" ✓ vs "Plants work correctly" ✗)
- Must be observable without debug tools ("Player can see the plant change size" ✓ vs "Internal state variable increments" ✗) — though internal criteria are also valid for test automation.

Categorize each criterion:
| Type | Meaning | Example |
| AUTO | Can be verified by automated test | "growth_stage increments after 7 days" |
| MANUAL | Requires human verification | "Plant growing animation plays smoothly" |
| DEFERRED | Cannot be verified until other systems exist | "Letter mentions garden state" (depends on Letter system) |

Minimum: 3 acceptance criteria per system. 5+ is better.

Draft, get approval, write.

Step 12: Update Status

Set the GDD status field to "Designed" or "In Review" based on user preference.
Update systems-index.md: set this system's Status to "In Review".

Step 13: Offer Design Review

Ask: "Would you like to run design-review on this GDD?"
If yes: load the design-review skill.
