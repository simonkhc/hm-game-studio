name: code-review
description: Reviews implemented code for quality, standards compliance, architecture soundness, and testability. Checks each file against 6 criteria: architecture clarity, engine idioms, data-driven design, performance, testability, maintainability. Returns APPROVED / CHANGES REQUESTED / BLOCKED with specific file paths and line references.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: lead-programmer

Code Review — Quality Inspection

Reviews one or more files of implemented code against the project's coding standards.
The goal: catch problems early, before they compound.

This skill is READ-ONLY. It does not modify any files.

---

Phase 1: Identify Files to Review

If the user specified files: read them.
If the user said "review the last story": read the story file, extract file references from technical notes.
If the user said "review all new code": use git to find changed files.
  terminal("git diff --name-only HEAD~1") or ask user for file list.

If no files found: "No code changes detected. Nothing to review."

Phase 2: Load Standards Context

Read the coding rules for each file's path:
- Files in src/gameplay/ → hm-game-studio/rules/gameplay-code.md
- Files in src/core/ → hm-game-studio/rules/engine-code.md
- Files in src/ui/ → hm-game-studio/rules/ui-code.md
- Files in src/ai/ → hm-game-studio/rules/ai-code.md
- etc. (check hm-game-studio/rules/ for all path mappings)

Read docs/architecture/control-manifest.md for project-specific rules.
Read the relevant ADRs if the code touches architected systems.

Phase 3: Run 6 Review Criteria

For each file, check:

3a. Architecture clarity
- Are system boundaries clear? Can you tell where this system ends and another begins?
- Is data flow explicit? (Events, signals, direct calls, shared state — pick one pattern and stick with it.)
- Are cross-system dependencies visible? (Implicit coupling is bad. Explicit dependencies are good.)
- Flag: "File [path] mixes UI logic with gameplay state. UI should not own game state."

3b. Engine idioms
- Does the code follow the engine's conventions?
  Godot: signals over direct node references, @export for exposed variables, @onready for delayed init
  Unity: MonoBehaviour lifecycle, SerializeField for exposed fields, events over Update polling
  Unreal: UPROPERTY/UCLASS/UINTERFACE macros, delegates for communication
- Flag: "File [path] uses direct node references instead of signals. This couples the UI to a specific scene tree."

3c. Data-driven design
- Search for hardcoded numeric literals (excluding 0, 1, -1, 100).
- Check: should any of these be in a config file?
- Flag: "File [path], line 42: hardcoded growth_rate = 7. This should be in assets/data/gameplay.json."
- Check: does the code read config values from the right place?
- Acceptable: config file at assets/data/, loaded at init or via autoload.

3d. Performance
- Search for patterns that cause frame drops:
  - File access in update loops (_process, Update, Tick)
  - Object allocation in hot paths (new Node, Instantiate, SpawnActor per frame)
  - Expensive loops (nested loops over large arrays every frame)
- Flag with file path and line number.
- Acceptable: pre-allocated object pools, cached references, dirty-flag patterns.

3e. Testability
- Can this code be tested in isolation?
  - Are dependencies passed in (dependency injection) or hardcoded (singletons)?
  - Are there interfaces/abstract classes that can be mocked?
- Does the code have any test files?
  Search tests/ for related test files.
  If not: "No tests found for [path]. Consider adding unit tests."
- Flag: "File [path] uses a singleton [name] directly. This makes it impossible to test in isolation."

3f. Maintainability
- Is the code readable? (meaningful names, comments where needed, consistent formatting)
- Is there dead code? (commented-out blocks, unreachable branches, unused imports)
- Is there duplicated logic that should be extracted?
- Flag: "File [path] lines 30-45 and 78-93 contain nearly identical logic. Extract to a shared function."

Phase 4: Determine Verdict

| Verdict | Criteria | Action |
|---|---|---|
| APPROVED | No issues or only LOW severity | None needed |
| CHANGES REQUESTED | MEDIUM issues, no BLOCKING | List specific changes with file paths |
| BLOCKED | HIGH/BLOCKING issues | Must fix before merge |

Phase 5: Report

Present the review in this format:

```
## Code Review: [file paths]

### Standards Checked
[6 criteria checked against rules/[path].md]

### Issues Found
**[BLOCKING] [file]:[line]** — [description]
**[HIGH] [file]:[line]** — [description]
**[MEDIUM] [file]:[line]** — [description]

### Verdict: [APPROVED / CHANGES REQUESTED / BLOCKED]

### Summary
- Files reviewed: [N]
- BLOCKING/HIGH issues: [N]
- MEDIUM/LOW issues: [N]
- No issues: [N] files
```

Phase 6: Offer Fixes

If BLOCKED: "There are [N] blocking issues. Should I fix them?"
If CHANGES REQUESTED: "There are [N] suggested changes. Want me to apply them?"
If user says yes: proceed file by file with patch.

---

Edge Cases

- File doesn't follow any known pattern: Flag as "STYLE: no established pattern" — not a blocker, but note for consistency.
- User disagrees with a finding: They may override. Record their reasoning in the review notes.
- Same issue in multiple files: Report once with all affected files listed. Don't repeat.
- Empty file or file with only comments: Flag as "NO IMPLEMENTATION" — may be intentional (interface definition).
