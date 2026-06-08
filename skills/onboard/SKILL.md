name: onboard
description: Guide a new team member through the project's conventions, tools, agents, and 7-phase pipeline. Role-specific orientation (designer/programmer/artist/producer/QA) with tailored workflow paths. Covers project structure, key conventions (GDD 8-section, ADR format, data-driven design, review modes), development workflow from concept to release, and available skills per role.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Onboard — New Team Member Orientation

Walks a new developer through the project's state, conventions, tools, and workflow. Provides a personalized orientation based on the user's role and the project's current phase.

---

Phase 1: Project Landscape

Read production/stage.txt — extract current phase.
Read production/review-mode.txt — extract review mode.
If files don't exist: "Project hasn't been configured yet. Run start or adopt first."

Read design/gdd/game-concept.md — extract game title and pillars (if exists).
Count GDDs: search_files(pattern='*.md', path='design/gdd/') — exclude game-concept and systems-index.
Count ADRs: search_files(pattern='adr-*.md', path='docs/architecture/').
Count source files: search_files(pattern='*.gd', path='src/') or equivalent per engine.
Count stories: search_files(pattern='story-*.md', path='production/epics/').

Present the landscape:
"Welcome to [project] (a [pillar summary] game).
Current phase: [phase]. Review mode: [mode].
Project stats: [N] GDDs, [M] ADRs, [P] source files, [S] stories."

---

Phase 2: Role-Specific Orientation

Ask: "What's your role on this project?"
Use clarify:
1. Designer — game mechanics, systems, balance, narrative
2. Programmer — implementation, architecture, testing
3. Artist — visual assets, style, animations
4. Producer — planning, tracking, process
5. QA — testing, bug tracking, quality
6. Generalist — doing a bit of everything

Based on role, present the relevant workflow:

Designer workflow:
"Your primary skills: brainstorm (concept generation) → design-system (GDD authoring) → design-review (quality gate) → quick-design (small changes)."
"Your outputs live in: design/gdd/, design/ux/, design/quick-specs/."
"Key rule: every GDD needs all 8 sections (Overview, Fantasy, Rules, Formulas, Edge Cases, Dependencies, Tuning Knobs, Acceptance Criteria)."

Programmer workflow:
"Your primary skills: dev-story (implementation) → code-review (quality) → story-done (completion)."
"Your outputs live in: src/gameplay/, src/core/, src/ui/, etc."
"Key rules: data-driven design (all values in config), no magic numbers, signals over direct coupling, tests for all gameplay logic."

Artist workflow:
"Your primary skills: art-bible (style guide) → asset-spec (catalog) → asset-audit (quality check)."
"Your outputs live in: assets/art/, assets/audio/, assets/vfx/."
"Key rules: naming conventions from technical-preferences.md, size budgets respected, format compliance."

Producer workflow:
"Your primary skills: sprint-plan → sprint-status → milestone-review → retrospective → gate-check."
"Your tracking lives in: production/sprints/, production/epics/, production/playtests/."
"Key rule: milestone reviews before phase transitions, retrospectives after each sprint."

QA workflow:
"Your primary skills: test-setup → bug-report → playtest-report → regression-suite → test-flakiness."
"Your reports live in: production/bugs/, production/playtests/, tests/."

---

Phase 3: Framework Orientation

Explain the 7-phase pipeline:
"Phase 1: Concept — game idea, pillars, systems list
Phase 2: Systems Design — detailed GDDs for each system
Phase 3: Technical Setup — architecture decisions, ADRs, control manifest
Phase 4: Pre-Production — UX specs, epics, stories, sprint plans, vertical slice
Phase 5: Production — implement stories sprint by sprint
Phase 6: Polish — performance, balance, playtesting, accessibility
Phase 7: Release — checklist, launch, publish"

Explain review modes:
"Full: director reviews at every key step. Best for teams and learning users.
Lean: reviews only at phase transitions. Default for solo devs.
Solo: no reviews. Maximum speed for game jams and prototypes.
Current mode: [mode] from production/review-mode.txt."

Explain agent system:
"The framework includes 49 agent prompts in hm-game-studio/agents/.
Use delegate_task() to spawn agents for specialized work:
- Directors (tier 1): creative-director, technical-director, producer, art-director
- Leads (tier 2): game-designer, lead-programmer, narrative-director, etc.
- Specialists (tier 3): gameplay-programmer, ui-programmer, qa-tester, etc.
- Engine specialists: godot-specialist, unity-specialist, unreal-specialist"

---

Phase 4: Tools and Conventions

Key tools the developer will use:
- read_file / write_file / patch — file operations
- search_files — finding code and docs
- clarify — structured decisions and confirmations
- delegate_task — spawning specialized agents
- terminal — builds, git, test runner

Key conventions:
- GDD format: 8 sections required, Status field with valid values
- ADR format: Status, Context, Decision, Consequences, Dependencies, Engine Compatibility, GDD Requirements
- Coding standard: data-driven, no magic numbers, dependency injection, signals over coupling
- Story format: acceptance criteria, ADR references, test strategy, dependencies
- Config format: JSON in assets/data/, versioned schema, documented fields

---

Phase 5: Current Sprint and Next Action

If a sprint plan exists: read production/sprints/sprint-[N].md.
List: "Current sprint: [N] — [goal]. Stories: [N] Must Have, [N] Should Have.
Available work: [list of READY stories without assignees].
Blockers: [list]."

If no sprint plan exists: "We're in [phase] phase. No active sprint yet. The next step is [next phase action]."

---

Phase 6: Q&A

Ask: "Any questions?"
Common questions and answers:
"Where do I start?" → "Check the sprint plan for available work, or look at the next READY story."
"What if I break something?" → "Git tracks everything. Tests catch regressions. We fix forward."
"How do I get help?" → "Use delegate_task() with the appropriate agent prompt from hm-game-studio/agents/."
"Where is [thing]?" → "Refer to hm-game-studio/docs/directory-structure.md for the complete layout."

If no questions: "Orientation complete. You're ready to work."

---

Edge Cases

- First developer on a brand new project: "You're the first. Focus on foundations: concept doc, pillars, systems index."
- Returning after long absence: "Since you were last here: updated phase from [old] to [current], [N] new GDDs, [M] new ADRs. Key decisions: [summary from session-state/active.md]."
- Developer doesn't know their role: Default to Generalist. "You'll work across the stack. Start with what's most urgent."

---

Phase 7: Framework Navigation Reference

Key files every developer should know:
- hm-game-studio/FRAMEWORK.md — core framework configuration and collaboration protocol
- hm-game-studio/INDEX.md — complete file catalog of all 200+ framework files
- hm-game-studio/docs/agent-roster.md — all 49 agents with when-to-use guidance
- hm-game-studio/docs/director-gates.md — gate definitions for phase transitions
- hm-game-studio/docs/workflow-catalog.yaml — machine-readable phase/step definitions
- hm-game-studio/rules/ — coding standards per file path

The hm-game-studio/ directory is the framework. Your game project is separate. Never modify files inside hm-game-studio/ unless you're contributing to the framework itself.

---

Phase 8: Common Pitfalls

- Forgetting to update systems-index.md when adding a new GDD: "The index is the source of truth for system dependencies. Update it alongside each new GDD."
- Writing code before GDD is approved: "Design first, code second. An approved GDD saves you from rewriting code."
- Skipping the gate check: "Gate checks exist to catch problems early. Running them takes 5 minutes. Fixing what they catch takes hours."
- Adding features that aren't in any story: "Scope creep kills sprints. If it's not in the sprint plan, it doesn't get built this sprint."

---

Edge Cases (continued)

- Project has no hm-game-studio/ directory: "The framework isn't installed. Clone it alongside your project."
- Developer is only doing a quick contribution: "Focus on the specific skill they need. Skip the full orientation."
- Developer is non-technical (writer, designer): Skip code-related sections. Focus on design docs and narrative tools.
