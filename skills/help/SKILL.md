name: help
description: Context-aware 'what's next' guidance. Reads project state (stage.txt, review-mode.txt, artifact counts) and recommends the appropriate next skill based on current phase and gaps. Can also produce a quick-reference listing of all skills by category.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Help — Context-Aware Guidance

Provides guidance on what to do next based on the current project state.
This skill is READ-ONLY. It does not modify any files.

---

Phase 1: Read Project State

Read production/stage.txt for current phase.
If missing: run project-stage-detect first to determine phase.
Read production/review-mode.txt for review intensity.
Scan: design/gdd/game-concept.md, systems-index.md, adr-*.md, story files, source files, playtest reports.

---

Phase 2: Determine Context

If no stage.txt and no artifacts:
"Fresh project detected. Run start to begin guided onboarding."

If stage.txt exists:
Current phase: [phase]
Review mode: [full/lean/solo]

Check if there are obvious gaps in the current phase (using project-stage-detect logic):
- Phase 1 but no concept doc: "No concept document — run brainstorm."
- Phase 1 but no systems index: "No systems mapped — run map-systems."
- Phase 2 but GDDs not complete: "GDDs still in progress — run design-system for the next system."
- Phase 2 but no cross-review: "All GDDs done? Run review-all-gdds."
- Phase 3 but 0 ADRs: "No architecture decisions — run architecture-decision."
- Phase 3 but ADRs not accepted: "ADRs still Proposed — accept them."
- Phase 4 but no stories: "No stories created — run create-stories."
- Phase 4 but no sprint plan: "Run sprint-plan to start your first sprint."
- Phase 5 but story is done: "Story complete? Run story-done for review."

---

Phase 3: Suggest Next Skill

Based on the gap analysis, suggest the single most impactful next step:

| Situation | Suggested skill | Why |
|---|---|---|
| No concept | brainstorm | Everything starts with a concept |
| Concept exists, no systems | map-systems | Know what to build before building |
| Systems listed, no GDDs | design-system | Design before code |
| GDDs done, no ADRs | architecture-decision | Tech decisions before implementation |
| Stories exist, none started | dev-story | Time to build |
| Story done | story-done | Review before moving on |
| Stuck / not sure | project-stage-detect | Assess where you are |

---

Phase 4: Quick Reference (Optional)

If the user asks for a full listing, present skills organized by category:

```
## Skills by Category

### Onboarding
start — New project setup
adopt — Existing project adoption
help — This skill
project-stage-detect — Phase assessment

### Design
brainstorm — Concept generation
design-system — GDD authoring
design-review — GDD quality review
quick-design — Small design changes

### Architecture
architecture-decision — ADR creation
gate-check — Phase transition validation

### Implementation
dev-story — Story implementation
story-done — Completion review
code-review — Code quality inspection

### Planning
create-epics — Epic decomposition
create-stories — Story creation
sprint-plan — Sprint planning
sprint-status — Progress tracking

### Testing
test-setup — Test framework
bug-report — Bug documentation
playtest-report — Playtest documentation

### Release
release-checklist — Pre-release validation
changelog — Technical release notes
patch-notes — Player-facing notes
```

---

Phase 5: Output

Present guidance in conversation:
"Current phase: [phase] (review mode: [mode])
Gap: [specific gap]
Next step: [specific skill recommendation]

Would you like to run [skill] now?"

---

Phase 6: Skill Search

If the user asks about a specific topic (e.g., "How do I test?" or "I need to release"):
Search the skill names for matching keywords and present relevant skills:

| Topic | Relevant skills |
|---|---|
| Testing | test-setup, test-flakiness, test-evidence-review, test-helpers, qa-plan |
| Release | release-checklist, launch-checklist, changelog, patch-notes, hotfix |
| Design | brainstorm, design-system, design-review, quick-design |
| Architecture | architecture-decision, architecture-review, create-architecture |
| Bugs | bug-report, bug-triage |
| Planning | create-epics, create-stories, sprint-plan, sprint-status |
| Polish | perf-profile, balance-check, playtest-report, asset-audit |

---

Phase 7: Quick Navigation

If the user asks "What skills exist?":
Offer: "There are 74 skills across 8 categories. Categories: Onboarding (7), Design (5), Art/UX (5), Architecture (4), Stories/Sprints (9), Reviews (9), QA/Testing (10), Production (5), Release (6), Creative (3), Team (9). Want to see a specific category?"

If the user asks "I need help with [specific tool or concept]":
Map common questions to skills:
- "How do I write a GDD?" → design-system
- "How do I create a test?" → test-setup
- "How do I ship the game?" → release-checklist
- "How do I fix a bug?" → bug-report + bug-triage
- "How do I plan work?" → create-stories + sprint-plan
- "My code is slow" → perf-profile

---

Phase 8: Context Help

If the user is in the middle of another skill and asks for help:
- Their current context matters. Ask: "Are you stuck on a specific step in [current skill]?"
- If yes: read the skill they're running and offer guidance on the specific step.
- If no: proceed with normal help flow.

---

Edge Cases

- No project files exist at all: "This doesn't look like a game project directory. Run hermes in your game project directory, then try help again."
- User asks for help with a tool outside the framework: "That's not part of HMGS. Can you clarify what you need?"
- User is clearly frustrated: "Let's reset. What's ONE thing you want to accomplish right now?"
