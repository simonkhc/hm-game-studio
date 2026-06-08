name: soak-test
description: Long-duration stability test — run game for extended period, monitor memory, FPS, resource leaks.
allowed-tools: terminal, read_file, write_file, clarify
model: sonnet
agent: qa-tester

Soak Test — Long-Duration Stability

Runs the game for an extended period to find memory leaks, resource exhaustion, and stability issues that don't appear in short sessions.

---

Phase 1: Setup

Decide duration: 1 hour minimum. 4+ hours for thorough test.
Set up monitoring: note what to watch (FPS, memory, object count, open files).

Phase 2: Run Test

terminal("[engine-launch-command]") or ask user to run the game.
If headless mode available: run without graphics for longer duration.

Monitor:
- Memory growth: does it increase steadily (leak) or stabilize (healthy)?
- FPS: does it degrade over time?
- Loading: do repeated scene transitions increase load times?

Phase 3: Check Results

After test duration:
- Memory difference: end - start
  If > 100MB growth: probable leak → HIGH
  If 10-100MB: minor growth → MEDIUM
  If < 10MB: healthy
- FPS degradation: end FPS vs start FPS
  If > 20% drop: investigate
- Error log: check output for warnings, errors, exceptions

Phase 4: Report

Write report: docs/performance/soak-test-[date].md
- Duration, platform, build version
- Memory: start/end/delta
- FPS: start/end/delta
- Errors found: list
- Verdict: PASS / LEAK_DETECTED / CRASHED

Phase 6: Practical Application

After performing the core analysis, offer to act on findings:
- "I found [N] issues. Should I fix them now or create stories for them?"
- "Top recommendation: [single most impactful change]."

Phase 7: Documentation Update

If findings affect other documentation:
- "GDD [name] needs updating: [specific change]."
- "ADR [name] is affected by this finding: [impact]."
- "Should I update these now?"

Phase 8: Prevention

To prevent this issue from recurring:
- "Add a check to [relevant skill]: [specific addition]."
- "Update the coding rules: [specific rule]."
- "Add to code review checklist: [specific item]."

---

Quality Checklist

Every skill should meet these standards:
- [ ] Pre-conditions: what must exist before running
- [ ] Clear phases/steps with numbered instructions
- [ ] Specific file paths and tool commands
- [ ] Branching logic: if X, do Y; if error, do Z
- [ ] Edge cases explicitly handled
- [ ] Output artifacts defined with exact paths
- [ ] Post-checks to verify success
- [ ] YAML frontmatter: name, description, allowed-tools, model, agent
- [ ] 100+ lines of substantive content

---

Edge Cases

- User runs this at the wrong phase: "This skill is designed for [phase]. You're in [current phase]. Consider [alternative skill] instead."
- Engine-specific variations: "This skill assumes [engine]. If you're using a different engine, adjust the file paths and commands accordingly."
- User cancels mid-skill: "Partial results are saved. Re-run to continue."

---

Phase 9: Decision Tree

If the user asks "what if I skip this step?":
- "Skipping [step] means [consequence]. Acceptable if [condition]."
- "If you're in solo mode, this step is optional by design."

If the user asks "what tool do I use for this?":
- "Use [hermes_tool] for [purpose]."
- "Example: read_file(path) to read the file, search_files(pattern, path) to find occurrences."

If the user encounters an error:
- Error: [common error message]
- Cause: [what went wrong]
- Fix: [how to resolve]

---

Phase 10: Multi-Project Considerations

If you're running this across multiple game projects:
- Each project has its own hm-game-studio/ reference (same framework, different project)
- Save data lives in each project's production/ directory
- Skills are shared across all projects

---

Verification

After running this skill, confirm:
- [ ] Output file exists at the expected path
- [ ] Content is correct
- [ ] Related files are updated (if applicable)
- [ ] User knows the next step

Not sure? Run the post-checks section again.
