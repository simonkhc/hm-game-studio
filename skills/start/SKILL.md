name: start
description: Guided first-time onboarding for a brand new game project. Walks through concept brainstorming, engine selection with version pinning, pillar definition, core loop design, systems mapping, and review mode selection. Creates game-concept.md, systems-index.md, technical-preferences.md, and sets stage.txt.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: producer

Start — Project Onboarding

Full guided onboarding for a brand new game project. Designed for projects that have NO existing artifacts.
If you have existing code/docs, use adopt instead.

Output: design/gdd/game-concept.md, design/gdd/systems-index.md, docs/technical-preferences.md, production/stage.txt, production/review-mode.txt

---

Pre-Checks

Check if any artifacts already exist:
- Does design/gdd/game-concept.md exist?
- Does design/gdd/systems-index.md exist?
- Does production/stage.txt exist?

If ANY of these exist: "This project already has some artifacts. The start skill is for fresh projects. Use adopt for brownfield adoption, or project-stage-detect to assess current state."

Options for the user: "Overwrite existing and start fresh" / "Use adopt instead" / "Cancel"

---

Step 1: Project Identity

Ask: "What's the game's name? (Working title is fine — can change later.)"
Accept any answer. Don't overthink naming at this stage.
If the user gives a long title: ask "What's the short version? (1-3 words for file naming)"

Write the project name to a temporary variable: it'll be used in the concept document.

---

Step 2: Game Type Assessment

Ask ONE question at a time:

2a. "What genre best describes your game idea?"
Options: Platformer / RPG / Puzzle / Simulation / Strategy / Adventure / Action / Horror / Narrative / Educational / Other
If "Other": ask "Describe it in 1-2 sentences."

2b. "What's your experience level with this type of project?"
Options:
- "First game ever" → suggest smaller scope, provide more guidance
- "Experienced, but first time using this engine" → suggest reference docs
- "Experienced, know the engine" → minimal guidance, focus on design decisions

2c. "What's the intended scope?"
Options:
- "Game jam (48-72 hours)" → set review-mode to solo, skip heavy process
- "Small project (1-3 months)" → lean review mode, focus on MVP
- "Medium project (3-12 months)" → standard full pipeline
- "Large project (12+ months)" → full process, all gates

---

Step 3: Brainstorm Concepts

Load and execute the brainstorm skill from hm-game-studio/skills/brainstorm/SKILL.md.
Briefly: generate concepts → pick one → stress-test pillars → confirm direction.

Do NOT skip the pillar stress test (Step 4 of brainstorm). Pillars that aren't specific will cause problems later.
"The pillars should be so clear that if you and another designer disagree, you can look at the pillar and know who's right."

If the user is experienced and wants to skip brainstorm: allow it. "I'll create a minimal concept doc from your description. Write the elevator pitch in one sentence."

---

Step 4: Write Concept Document

Use the template at hm-game-studio/templates/game-concept.md.
Fill with the results from Step 3.

Required minimum content:
- Elevator pitch (one sentence)
- Core fantasy (what the player imagines themselves doing)
- 3-5 pillars (specific, falsifiable design values)
- At least 1 anti-pillar (what the game intentionally avoids)
- 30-second loop description

Write to design/gdd/game-concept.md.
Get approval before writing.

---

Step 5: Configure Engine

Load and execute setup-engine from hm-game-studio/skills/setup-engine/SKILL.md.
Determine: engine name, version, language, naming conventions, performance budgets.

If the user doesn't know which engine: present options:
- "Godot 4 — free, lightweight, great for 2D, GDScript"
- "Unity — free tier available, C#, largest asset store, good for 3D"
- "Unreal 5 — free with royalty, C++/Blueprints, best for high-end 3D"
- "Custom engine" — only if user has a specific reason

If the user doesn't have a preference: "Godot 4 is a great starting point. Open source, small download, great 2D support."

Write to docs/technical-preferences.md.

---

Step 6: Map Systems

Load and execute map-systems from hm-game-studio/skills/map-systems/SKILL.md.
Briefly: list all systems the game needs → map dependencies → assign priorities.

Do NOT skip this step. "Even a simple game has 5-10 systems. Listing them now prevents nasty surprises."
Focus on the core loop: "What's the minimum set of systems needed for the player to experience the core fantasy?"

Write to design/gdd/systems-index.md.

---

Step 7: Set Review Mode

Use clarify to set the review intensity:
"How much design review would you like throughout the project?"
Options:
1. "Full — Director reviews at each key step. Thorough but slower. Best for teams."
2. "Lean — Reviews only at phase transitions. Balanced. (Recommended for solo devs.)"
3. "Solo — No reviews. Maximum speed. Best for game jams and prototypes."

Write to production/review-mode.txt.

---

Step 8: Set Stage

Write to production/stage.txt: "concept"

---

Step 9: Summary

Present the onboarding summary:

```
## Project Onboarding Complete!

**Project:** [name]
**Engine:** [engine] [version]
**Review mode:** [full/lean/solo]
**Current phase:** Concept

### Created
- design/gdd/game-concept.md ✅
- design/gdd/systems-index.md ✅
- docs/technical-preferences.md ✅
- production/stage.txt ✅
- production/review-mode.txt ✅

### Next Steps
1. Run design-system to create detailed GDDs for your MVP systems
2. Design order: follow the layers from systems-index.md
3. First system to design: [first system in dependency order]
```

---

Edge Cases

- User changes mind about concept during Step 5-7: Go back to Step 3. Don't force a decision made 5 minutes ago.
- User wants to skip all process and just build: "Skip to production? I'll set solo review mode and minimal docs. But you'll need at least a concept doc and system list — everything else is optional."
- No engine installed on this machine: Setup-engine will note this. Continue with documentation.
