name: vertical-slice
description: Build a production-quality end-to-end build proving the core loop is fun and the architecture is sound. Requires real architecture, config files, real naming conventions, and placeholder art. One complete [start → play → resolution] cycle. 3 playtest sessions. Verdict: PROCEED / PIVOT / KILL.
allowed-tools: read_file, write_file, terminal, clarify, delegate_task, search_files
model: sonnet
agent: lead-programmer

Vertical Slice — Core Loop Validation Build

A vertical slice is a production-quality end-to-end build that proves three things:
1. The core loop is fun (playtest evidence)
2. The architecture supports the design (no throwaway code)
3. The team can deliver at quality bar (real naming, real patterns)

This is NOT a prototype. Prototypes test one mechanic. A vertical slice tests the entire core loop.
Placeholder art and audio are ACCEPTABLE. Placeholder code architecture is NOT.

Output: prototypes/vertical-slice/ + playtest reports + verdict file

---

Phase 1: Read Context

Read design/gdd/game-concept.md — extract the core loop definition (30-second, 5-minute, session).
Read design/gdd/systems-index.md — list of MVP systems required.
Read design/ux/ — any UX specs for key screens (if they exist).
Read docs/technical-preferences.md — engine, naming conventions, performance budgets.
Read any accepted ADRs that affect the systems being built.

Determine the minimum viable set of systems to demonstrate the core loop:
- What is the shortest path from "player launches game" to "player experiences the core fantasy"?
- What systems are ABSOLUTELY required? Everything else is stubbed.
- What content is minimally needed? (1 plant, 1 interaction, 1 day cycle — not 50 plants and 10 interactions.)

Present to user: "The vertical slice will demonstrate: [description]. It requires systems: [list]. It will stub: [list]. Content scope: [scope]."

---

Phase 2: Architecture Setup

Create the architecture for the slice. Every line must be production-quality.

2a. Scene/structure setup
- Create the scene tree (engine-specific: Godot scenes, Unity prefabs, Unreal levels)
- Set up autoloads or bootstrapping (engine start sequence)
- Establish the root scene that bootstraps everything

2b. Data/config files
- Create config files in assets/data/ for ALL tunable values
- Even values you think won't change — put them in config
- Format: JSON (preferred for cross-engine compatibility)

2c. Input handling
- Set up input map (engine-specific input system)
- Mouse/touch support for click interactions
- Keyboard shortcuts for debug actions (F5 = save state, F6 = advance day)

2d. Error boundaries
- No crash on missing files (graceful fallback)
- No crash on invalid state (reset to default)
- Error logging for debugging

2e. Delegation decision
If this is a large slice (>3 systems): delegate architecture to lead-programmer via delegate_task().
If this is a small slice (<3 systems): set up architecture yourself.

---

Phase 3: Implement Systems

Implement the systems in this ORDER. Each builds on the previous:

3a. Boot/loading system (Day 0)
- Game launches, shows title or enters first scene
- Save file loads (or creates new if none exists)
- Day calculation runs (is it first launch or returning player?)

3b. Core loop step 1: Player arrives (Day 1)
- Player sees the main scene (room, garden, window, etc.)
- Player sees the first interactive element
- Player can interact with it

3c. Core loop step 2: Player acts (Day 1)
- Interaction produces feedback (visual, audio, or both)
- State changes (garden grows, letter arrives, etc.)
- Player sees the result

3d. Core loop step 3: Anticipation (Day 1 → Day 2)
- Player can advance to next day (or close and reopen)
- Day 2 shows changed state
- Player sees that their action from Day 1 had an effect

3e. Polish pass
- Transition animations between states
- Visual feedback for interactions
- Basic ambience (visual, not yet audio)

For each system: propose approach → get approval → implement → test → move on.

---

Phase 4: Playtest (3 Sessions)

Run 3 structured playtest sessions. Use the playtest-report skill for each.

Session 1: New player experience
- Give the build to someone who has never seen it
- Do NOT give instructions
- Observe: can they figure out what to do?
- Minimum pass: player interacts with the core mechanic within 30 seconds

Session 2: Core loop engagement
- Let the player play for 10-15 minutes (across multiple in-game days)
- Observe: do they want to keep going? Do they check "what happens tomorrow"?
- Minimum pass: player voluntarily plays through at least 3 in-game days

Session 3: Quality bar
- Is the experience polished enough to show someone?
- Are there blocking bugs?
- Minimum pass: no crashes, no dead ends, feedback feels good

If Session 1 fails: stop. Fix the onboarding. Retest Session 1.
If Session 2 fails: the core loop needs work. PIVOT or iterate.
If Session 3 fails: more polish needed before PROCEED.

---

Phase 5: Evaluate and Verdict

After 3 playtest sessions, evaluate:

PROCEED: All 3 sessions pass. Core loop is fun. Architecture holds. Quality bar acceptable.
- Gate check passes. Move to Phase 5 (Production).
- Write verdict to prototypes/vertical-slice/verdict.md: "PROCEED"

PIVOT: Core loop works but isn't fun enough. Or Sessions 1-2 pass but Session 3 fails on quality.
- Document what must change. Create a plan for the next iteration.
- Write verdict: "PIVOT — [reasons]"

KILL: Core loop fundamentally doesn't work. Sessions 1 or 2 fail.
- Serious conversation with user: should the project continue?
- Write verdict: "KILL — [reasons]"

---

Phase 6: Post-Checks

- Verdict is documented in prototypes/vertical-slice/verdict.md
- If PROCEED: update stage.txt to "production" (if in pre-production)
- If PROCEED: create stories from the implemented systems (they're now reference implementations)
- If KILL: recommend a new brainstorming session with lessons learned

---

Edge Cases

- Engine limitation discovered during build: Document as a new ADR immediately. Decide: work around it or change engine?
- Missing art makes the slice ugly but functional: Expected. Note "Placeholder art — visual polish deferred to production."
- Player 1 figures it out but Player 2 doesn't: The tutorial/intro needs work before full production.
- Vertical slice takes longer than planned: Common. Don't sacrifice quality. But do evaluate: was it scope creep or accurate estimation?

---

Phase 7: Migration to Production

If verdict is PROCEED, plan the migration:

- What code from the slice is production-ready? (Everything, if you followed the rules.)
- What systems need expansion? (Stubbed systems need real implementations.)
- What content needs creation? (Placeholder art → real art, placeholder audio → real audio.)
- What's the estimated effort for full production?

Write migration notes to prototypes/vertical-slice/migration-plan.md.

---

Edge Cases

- No engine installed on this machine: "Can't build the slice from here. Run setup-engine first, or build manually and share the build."
- Slice depends on assets that don't exist: Use placeholders. "Draw a colored rectangle for the plant. It's the behavior we're testing, not the art."
- Player feedback contradicts each other: Look for patterns. "Two players said X, one said Y. Trust the majority but note the outlier."
