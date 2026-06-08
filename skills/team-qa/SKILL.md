name: team-qa
description: Coordinate qa-lead and qa-tester on test execution across features.
allowed-tools: read_file, write_file, delegate_task, clarify, search_files
model: sonnet
agent: qa-lead

Team QA — Multi-Agent Feature Coordination

Coordinates multiple specialists via delegate_task(tasks=[...]) to implement a QA feature end-to-end.
Each specialist gets a focused task, results are integrated, and the feature is validated.

---

Phase 1: Read Design Context

Read all relevant GDDs for the QA systems.
Identify: what needs design, what needs implementation, what needs art/audio/VFX.

From the design docs, extract:
- Core mechanics that must be implemented
- Data structures and interfaces between subsystems
- Acceptance criteria (these become the validation checklist)

Phase 2: Identify Required Specialists

Based on the feature scope:
- qa-lead: defines test strategy and priorities
- qa-tester: executes test cases and files bug reports
- gameplay-programmer: fixes bugs found during testing

Check each specialist's prompt in hm-game-studio/agents/ for the correct delegation format.

Phase 3: Spawn Agents

Use delegate_task(tasks=[...]) to spawn independent specialists in parallel.
Each task gets:
- goal: specific implementable objective (not "build everything")
- context: relevant GDD excerpts, file paths, interfaces from other systems
- toolsets: ['terminal', 'file'] for programmers, add 'web' for research tasks

IMPORTANT: Tasks must be independent (no task A waits for task B). 
If dependencies exist, sequence them: spawn A, wait for result, spawn B with A's output.

For each agent, include their role prompt from hm-game-studio/agents/ as context.

Phase 4: Integrate Outputs

Collect results from all spawned agents.
Check:
- Do the outputs work together? (interfaces match, data flows correctly)
- Are there conflicts? (two agents modified the same file)
- Is each piece testable in isolation?

If integration issues exist:
1. Identify the specific conflict
2. Fix it yourself (don't re-spawn — you have context they lack)
3. Document what was changed and why

Phase 5: Validate Against Acceptance Criteria

Read the acceptance criteria from the GDD.
For each criterion:
- If auto-checkable: run the test
- If manual: ask the user to verify
- Mark: PASS / FAIL / NOT TESTED

Phase 6: Report

Present:
```
## Team QA — Integration Report

### Agents Used
- [agent A]: [what they built] — [status]
- [agent B]: [what they built] — [status]

### Integration
- Conflicts resolved: [none / list]
- Interfaces matched: [yes / issues noted]

### Acceptance Criteria
- [ ] Criterion 1 — PASS
- [ ] Criterion 2 — PASS
- [ ] Criterion 3 — MANUAL (needs user verification)

### Verdict
INTEGRATED / PARTIAL / BLOCKED
```
Phase 7: Integration Testing

After all agents return their outputs:

1. Check interface compatibility between subsystems
   - Does agent A's output format match agent B's expected input?
   - Are all event/signal names consistent across implementations?
   - Do file paths referenced by one agent exist after another agent's work?

2. Run a quick smoke test of the integrated feature:
   - If build tool available: terminal("[engine-build-command]") — check for compilation errors
   - If not available: manual review of integration points

3. Flag any integration issues found
   - If BLOCKING: describe the issue and propose a fix
   - If non-blocking: note for the implementation phase

Phase 8: Verify Against Design

Read the original GDD for this feature.
For each design requirement from the GDD:
- Does the integrated implementation satisfy it?
- If no: flag as GAP and explain what's missing
- If partially: note what's done and what remains

Phase 9: Post-Integration Cleanup

- Remove any temporary/stub files created by agents during integration
- Ensure no duplicate code was created by parallel agents
- Verify naming consistency (both agents should use the same conventions from technical-preferences.md)

---

Edge Cases

- Agent produces broken code: Do not propagate errors. Fix the agent's output manually, then document what went wrong.
- Two agents modified the same file: Read both versions, merge changes manually, flag as integration risk for next time.
- Agent didn't complete within reasonable time: Accept partial output. Complete the remaining work yourself.
- Agent's output doesn't match design: Fix to match design. Document deviation as a learning point.
- Integration reveals design gap: Create a design-change note. Update GDD if needed.
Phase 10: Documentation

After successful integration:
- Update the relevant story files with: what was built, by which agent, any deviations from plan
- If the integration revealed missing documentation (config file docs, API docs), create the docs
- Log any tech debt discovered during integration

Phase 11: Handoff to Next Phase

- If this is a team-qa run: hand off verified feature to release pipeline
- If this is a team-release run: feature is ready for launch
- If this is a team-narrative run: content is ready for implementation
- General: update sprint status to reflect completed stories

---

Decision Framework for Conflicts

When agents produce conflicting outputs, use this priority:
1. Design docs (GDD/UX spec) are authoritative — agent opinions don't override design
2. ADRs are next — architecture decisions bind all agents
3. lead-programmer/lead-designer judgment resolves ambiguity — if conflict remains, escalate

Do NOT let agents override each other. You (the orchestrator) make the final call.

---

Agent Prompt Quality Check

Before spawning agents, verify the agent prompt is complete:
- [ ] Role defined clearly
- [ ] Task goal is specific and bounded
- [ ] Input context provided (relevant GDDs, ADRs, file paths)
- [ ] Output expected format specified
- [ ] Constraints listed (naming conventions, engine idioms, file locations)
- [ ] Toolsets provided (terminal, file, web, etc.)

Missing context is the #1 cause of wrong agent output. Take 30 seconds to verify before spawning.
