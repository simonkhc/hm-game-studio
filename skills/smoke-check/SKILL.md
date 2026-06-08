name: smoke-check
description: Quick verification that the game builds and runs — main scene loads, no crashes, input works.
allowed-tools: terminal, read_file, clarify
model: sonnet
agent: qa-tester

Smoke Check — Build Verification

A rapid test that the game boots and responds to basic input.
Run after any significant change to catch build-breaking issues immediately.

---

Phase 1: Build

Run the engine's build command:
- Godot: terminal("godot --headless --export-release [platform]") or check if project.godot exists
- Unity: terminal("[unity-path] -batchmode -buildTarget [platform] -projectPath . -executeMethod BuildScript.PerformBuild")
- Unreal: terminal("[uproject] -run=cook -target=...")

If the build fails:
- Show the error output
- Identify the likely cause (missing file, syntax error, broken reference)
- Ask: "Should I investigate this build error?"

If the engine isn't installed (common in CI-less setups):
- Note: "No build tool detected. Skipping automated build verification."
- Proceed to Phase 2 (manual launch check).

Phase 2: Launch Verification

If the engine is available:
terminal("[engine] [project] --no-header" or equivalent)
Check for:
- Exit code 0 (clean launch)
- No crash messages in output
- No missing resource warnings

If the engine is GUI-only (no headless mode):
- Ask user: "Can you launch the game and confirm the main scene loads?"
- Wait for confirmation.

Phase 3: Quick Interaction Test

If the game has a main menu or starting scene:
- Verify input works (keyboard/mouse/touch)
- Verify scene transitions work (menu → gameplay)
- No error messages in output log

Phase 4: Report

Verdict: PASS / FAIL / PARTIAL

PASS: Builds, launches, accepts input.
FAIL: Doesn't build or crashes on launch.
PARTIAL: Builds but has warnings or non-blocking issues.

If FAIL, provide specific error details and suggest fixes.

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

Phase 11: Integration with Other Skills

This skill pairs well with:
- [Related skill 1]: Run before this to prepare context
- [Related skill 2]: Run after this to validate output
- [Related skill 3]: Run alongside this for parallel work

---

Phase 12: Time Estimates

Typical time to run this skill:
- First time: [N] minutes (learning curve)
- Subsequent runs: [N] minutes (familiar path)
- Full depth: [N] minutes (all phases)

---

Final Verification

- [ ] All required outputs exist
- [ ] No unintended modifications to other files
- [ ] User confirms the result is correct
- [ ] Next action is clear

If any verification fails: re-run the relevant phase. Do not mark as complete until all checks pass.
