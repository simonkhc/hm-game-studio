name: brainstorm
description: Interactive game concept exploration. Generates 3 distinct concepts using Verb-First, Mashup, and MDA-Backward methods. For each concept defines: elevator pitch, core fantasy, 30-second loop, pillars, anti-pillars, and feasibility assessment. Runs pillar stress test via creative-director gate before committing to a concept.
allowed-tools: read_file, write_file, clarify, delegate_task
model: sonnet
agent: creative-director

Brainstorm — Concept Exploration

Generates and evaluates game concepts interactively. The user's tastes, constraints, and emotional goals drive the process. Three distinct generation techniques ensure variety.

Estimated time: 30-60 minutes of focused discussion.
Output: design/gdd/game-concept.md (only after user selects one concept)

---

Pre-Checks

Check if design/gdd/game-concept.md already exists.
If it exists: "A concept document already exists. Are you sure you want to brainstorm a new concept?"
Options: "Start fresh (overwrite)" / "Iterate on existing concept" / "Cancel"

If the user wants to iterate: read the existing concept and jump to Step 4 (Pillar Stress Test).

---

Step 1: Creative Discovery

Ask these questions one at a time. Don't present the whole list.

1a. "What games do you love and why?"
Probe for specifics: "You said you love Dark Souls. Is it the combat, the world design, the sense of accomplishment, or something else?"
Record: specific titles + the emotional/mechanical reasons.

1b. "What emotional experience do you want players to have?"
Guide: "Pick 2-3 emotions from: curiosity, pride, wonder, tension, relief, discovery, nostalgia, calm, excitement, belonging, mastery, surprise."
If the user picks too many: "Which 2-3 are most important? You can't design for all emotions at once."

1c. "What are your constraints?"
Ask about:
- Team size (solo? small team? large team?)
- Timeline (game jam weekend? 3 months? 1 year? indefinite?)
- Engine preference (Godot? Unity? Unreal? custom? none yet?)
- Target platforms (desktop? mobile? web? console?)
- Budget (free? paid? scope limited by budget?)

Record constraints. They will filter the generated concepts.

Step 2: Generate 3 Concepts

Use three distinct techniques. Explain each technique before applying it.

2a. Technique A: Verb-First Design

Explain: "We start with ONE verb — the core action the player does repeatedly. Everything else supports that verb."

Ask: "What's the most satisfying verb you can imagine? (jump, build, explore, trade, craft, race, solve, create, collect, sneak, negotiate, grow...)"

Once the user picks a verb:
- "What makes doing [verb] satisfying?" (feedback loop)
- "What makes doing [verb] challenging?" (obstacles)
- "What makes doing [verb] varied?" (depth)
- "What's the 30-second loop?" (verb → feedback → repeat)

Example:
Verb: "Grow"
30-sec loop: Plant → water → watch → repeat
Challenge: Seasons, pests, space management
Depth: Different plants need different care; cross-breeding creates hybrids

2b. Technique B: Mashup Method

Explain: "We combine two unexpected genres or themes to create something novel."

Ask: "Pick a genre you love." (platformer, RPG, strategy, puzzle, simulation, etc.)
Then: "Pick a second genre or theme that seems incompatible." (horror, cooking, accounting, gardening, architecture, etc.)

Find the intersection:
- "What does [genre A] do that [theme B] could benefit from?"
- "What does [theme B] bring that [genre A] usually lacks?"
- "What's the unique mechanic that only exists at this intersection?"

Example:
Genre: "Farming sim"
Theme: "Lovecraftian horror"
Intersection: You grow plants, but some of them are eldritch beings. Managing sanity while farming. The soil whispers.

2c. Technique C: Experience-First (MDA Backward)

Explain: "We start from the desired player emotion and design mechanics backward."

Show the MDA aesthetic categories:
- Sensation: visceral, sensory pleasure
- Fantasy: make-believe, role-playing
- Narrative: drama, story
- Challenge: obstacle course, mastery
- Fellowship: social framework
- Discovery: uncharted territory, exploration
- Expression: self-discovery, creativity
- Submission: pastime, mindless activity

Ask: "Which 2 aesthetics are most important for your game?"

Then design backward:
1. Aesthetics → "What dynamics create this aesthetic?"
2. Dynamics → "What mechanics produce those dynamics?"
3. Mechanics → "What's the 30-second loop of these mechanics?"

Example:
Aesthetic: "Discovery" + "Calm"
Dynamics: Player explores a small space each day, finding subtle changes
Mechanics: Daily login, procedural environmental changes, collectible observations
30-sec loop: Open game → observe what's new → log an observation → close

Step 3: For Each Concept, Define Core Elements

For all three concepts, define:
1. Elevator pitch (one sentence that passes the "10-second test")
2. Core fantasy (what the player imagines themselves being/doing)
3. 30-second loop (what the player does repeatedly)
4. 3-5 pillars (non-negotiable design values)
5. Anti-pillars (what the game intentionally avoids)
6. Why it works within the user's constraints

Present all three as a structured comparison:

```
## Concept A: [Title]
Pitch: [one sentence]
Fantasy: [what player imagines]
Loop: [30-sec loop]
Pillars: [3-5]
Feasibility: [within constraints?]

## Concept B: [Title]
...

## Concept C: [Title]
...
```

Ask: "Which concept resonates most? Or do you want to iterate on one?"

Step 4: Pillar Stress Test

For the selected concept, run a pillar stress test.

Use clarify for each question (or discuss if user prefers):

1. "Are these pillars falsifiable? If I watched someone play for 10 minutes, could I tell whether each pillar is being followed?"
   - If not: rewrite the vague pillars into specific, testable statements.
   - Example: BAD "The game is relaxing." GOOD "No timers. No fail states. Player can stop at any point without penalty."

2. "Do the pillars create productive tension with each other?"
   - Example: "Exploration" and "Safety" don't create tension → may be too safe. Boring.
   - Example: "Discovery" and "Accessibility" create tension → need to make discovery possible without being overwhelming.

3. "What's the anti-pillar that would make this game fail?"
   - Identify: "If we accidentally add [X], it breaks the game."
   - Example: Adding a score timer to a meditation game.

If review mode is "full": delegate to creative-director agent for thorough pillar review.
Return context: the concept doc draft, the 3-5 pillars, the anti-pillars.

Step 5: Write Concept Document

Only after the user has selected ONE concept and the pillars are stress-tested:

Use the template at hm-game-studio/templates/game-concept.md.
Fill each section: elevator pitch, core fantasy, MDA aesthetics, core loop (30-sec, 5-min, session, progression), pillars, anti-pillars, comparable titles, scope tiers.

Write to design/gdd/game-concept.md.
Get user approval before writing.

Step 6: Post-Checks

- Concept document has at least: pitch, fantasy, loop, pillars, anti-pillars.
- Pillars are specific (not "the game is fun").
- At least 1 anti-pillar is defined.
- User is excited about the direction. If they seem lukewarm, ask: "What's missing? What would make this concept exciting for you?"
