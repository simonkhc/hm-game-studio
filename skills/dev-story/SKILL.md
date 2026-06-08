name: dev-story
description: Implement a single story from end to end. Read story file + GDD + ADRs → propose implementation approach → get approval → write code → test → mark complete. Follows coding rules for each file path. One story at a time.
allowed-tools: read_file, write_file, patch, terminal, clarify, search_files
model: sonnet
agent: gameplay-programmer

Dev Story — Single Story Implementation

Implements one story from start to finish. The story must be READY (all dependencies done, design approved). If the story isn't READY, this skill will tell you before any code is written.

---

Phase 1: Read the Story

Read the story file from production/epics/[slug]/story-[name].md.
Extract:
- Story description and acceptance criteria
- GDD reference (which GDD to read)
- ADR references (which architecture decisions apply)
- Technical notes (file paths, engine notes)
- Story status — if not "Ready" or "In Progress", stop and explain why.

If the story file doesn't exist: "Story file not found at [path]. Check create-stories first."

---

Phase 2: Read Design Context

Read the referenced GDD. Focus on the sections that affect implementation:
- Detailed Rules: what the system must DO
- Formulas: how calculations work (implement these EXACTLY)
- Tuning Knobs: which values should be in config files
- Edge Cases: situations the code must handle
- Acceptance Criteria: what "done" means for this system

Read each referenced ADR. Extract architecture constraints.
- If ADR says "use signals for communication", don't use direct calls
- If ADR says "data must be JSON", don't use binary format

Read the relevant coding rules from hm-game-studio/rules/ for the file paths you'll be modifying.
- Files in src/gameplay/ → gameplay-code rules (data-driven, no hardcoded values)
- Files in src/ui/ → ui-code rules (no game state ownership)

---

Phase 3: Propose Implementation Approach

Present to the user:
"I'll implement [story name] by:

1. Creating [file path] — [what it does, key functions, data structures]
2. Modifying [file path] — [what changes, why]
3. Adding config to [file path] — [new config values, defaults]

Does this approach look right?"

If the user has feedback: adjust the plan before writing code.

---

Phase 4: Implement

Write code ONE FILE AT A TIME. For each file:

1. Explain what you're writing: "Writing [file path] — this contains [functionality]"
2. Get approval: "May I write this?"
3. Write the file
4. Verify: basic syntax check (if the engine provides one)

Follow the coding rules for the file's path:
- Data-driven: all tunable values go in config files (assets/data/), not in code
- No magic numbers: every constant has a name
- Error handling: every file operation, network call, and user input has error handling
- Comments: public functions have doc comments, complex logic has inline comments

If the story touches MULTIPLE files: present the full changeset before writing.
"If I change [file A], [file B], and create [file C], does that cover the story?"

---

Phase 5: Test

Run the tests relevant to this story:
- If tests exist: terminal("[test-runner] [test-file]") — collect results
- If no tests exist: "No tests found for this story. Write at least one test for the core logic."
- Minimum: one test per acceptance criterion

If tests fail:
- Read the error message
- Fix the code
- Retest
- Loop until tests pass OR you determine the test is wrong

If the test is wrong (acceptance criterion changed after test was written):
- Update the test to match the current acceptance criteria
- Document: "Test updated to reflect changed requirement"

---

Phase 6: Run Smoke Check

Run a quick smoke check (or ask user to): does the game still boot?
For engine-specific:
- Godot: check that the project loads without errors
- Unity: check that the scene loads without errors
- Unreal: check that the map loads without errors

If the game crashes: fix before proceeding. Don't accumulate broken changes.

---

Phase 7: Complete

Mark the story as complete:
- Update the story file's Status field to "Complete" or "Complete with Notes"
- If complete with notes: add a completion_notes section listing known gaps

Present: "Story [name] is implemented. Acceptance criteria:
- [ ] Criterion 1 — PASS
- [ ] Criterion 2 — PASS
- [ ] Criterion 3 — PASS

Ready for story-done review."

---

Edge Cases

- Story depends on unfinished work: Stop. "This story can't be implemented yet — it depends on [story X] which is not done. Implement [story X] first."
- User changes scope during implementation: "That's a change from the story. I'll finish what's in the story now, then we can create a new story for the additional work."
- Implementation reveals GDD gap: "The GDD doesn't specify [edge case]. What should happen here?"
- File already has changes in progress (not committed): "The file at [path] has uncommitted changes. I'll work alongside them, but let's make sure we don't conflict."

---

Phase 8: Tech Debt Awareness

During implementation, note any tech debt you deliberately introduce:
- "I'm hardcoding this value for now — config file will be set up in a later story."
- "This error handling is minimal — needs proper edge case coverage later."
- "This duplicates some logic from [other system] — should be extracted to shared utility."

For each tech debt item:
- Record: file path, what's wrong, why it's acceptable now
- Recommend: "Create a tech debt story: 'Extract shared [function] from [system A] and [system B]'"

Do NOT use tech debt as an excuse to write bad code. Only accept tech debt that genuinely simplifies the current story without breaking future work.

---

Phase 9: Documentation

After implementation:
- If the code introduces new config values: document them (add comments to config file)
- If the code changes a public API: update any documentation that references the old API
- If the code adds a new signal/event: note it in the relevant GDD's Dependencies section (if applicable)

Minimum: the code itself should be self-documenting (clear names, doc comments on public APIs).

---

Edge Cases (continued)

- Engine version-specific API: "This story uses [API] which was added in engine version [X]. Verify compatibility with your pinned version before merging."
- Story implementation is blocked by performance concern: "The straightforward implementation is slow. I'll write it simply first, then optimize. Document the concern for the perf-profile pass."
- Implementing this story breaks another: "This change conflicts with [other story/file]. Let's review: do we need both, or is the other story obsoleted?"
