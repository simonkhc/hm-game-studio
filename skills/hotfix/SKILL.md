name: hotfix
description: Emergency production bug fix following strict branch-tag-deploy-backport pattern. Branch from release tag, apply fix, test, tag patch, push, backport to main. Every step verified before proceeding.
allowed-tools: terminal, read_file, write_file, patch, clarify
model: sonnet
agent: release-manager

Hotfix — Critical Production Bug Fix

Emergency workflow for production bugs that can't wait for the next regular release.
Follows a strict branch → fix → tag → deploy → backport pattern. Every step is verified.

---

Phase 1: Confirm Need

Ask: "Is this bug critical enough for a hotfix?"
Use clarify:
- YES: CRITICAL severity, no workaround, affects many players
- NO: Can wait for next regular release
- UNSURE: Let's assess

If YES: proceed. If NO: "This can wait for the next release. File a bug report if you haven't already."
If UNSURE: "What's the impact if we wait [next release date] to fix this?"
- If user says "players will quit": proceed with hotfix.
- If user says "it's annoying but not blocking": defer to next release.

---

Phase 2: Identify Release Tag

terminal("git tag --list 'v*' | sort -V | tail -3")
If no tags: "No release tags found. Can't create a hotfix without a known release point. Are you sure this is a hotfix and not a regular fix?"
If tags exist: show the latest 3 tags. Ask: "Which release does this fix target?"
Default: the LATEST tag.

---

Phase 3: Create Hotfix Branch

terminal("git checkout [release-tag]")
If checkout fails: "Tag [tag] doesn't exist locally. Try: git fetch --tags"
terminal("git checkout -b hotfix/[short-description]")
Description should be 2-4 words, kebab-case: "hotfix/plant-growth-crash"

---

Phase 4: Apply the Fix

Read the relevant source files. Understand the bug.
Propose the fix approach before writing.
Get approval: "I'll fix [file:line] by [change]. OK?"

Apply using patch for targeted fixes. Use write_file for larger changes.
After each change: verify the file is syntactically correct (check engine syntax if possible).

---

Phase 5: Test

Run the relevant tests: terminal("[engine-test-command]") if available.
If no automated tests:
- Describe what manual verification was done: "Applied the fix, verified that [specific behavior] now works correctly."
- Ask user: "Can you confirm this fix works on your end?"

If the test fails: iterate on the fix. Do not tag until tests pass.

---

Phase 6: Tag and Push

terminal("git add -A")
terminal("git commit -m 'hotfix: [description]'")
If commit fails (nothing to add): "No changes detected. Was the fix already applied?"

Ask: "What patch version? Current is [latest]. [next patch]?"
E.g., if latest is v1.0.0, next patch is v1.0.1.

terminal("git tag v[next-patch]")
terminal("git push origin v[next-patch]")

---

Phase 7: Backport to Main

terminal("git checkout main")
terminal("git cherry-pick [commit-hash]")  # use the hotfix commit hash

If cherry-pick succeeds:
terminal("git push origin main")

If cherry-pick has conflicts:
- Explain: "The fix conflicts with changes on main. Resolve manually:"
- List conflicting files
- Ask user to resolve and push, OR do it yourself if the conflict is simple

---

Phase 8: Document

Write to production/releases/hotfix-v[next-patch].md:
- Bug fixed: [bug number or description]
- Root cause: [what caused it]
- Fix: [what changed]
- Files changed: [list]
- Date: [date]

---

Edge Cases

- Git not configured (no user.name/user.email): "Git needs configuration first. Run: git config user.name '...' and git config user.email '...'"
- Multiple hotfixes in progress: Each hotfix needs its OWN branch from the release tag. Do NOT stack hotfixes on the same branch.
- Release tag doesn't exist locally: "git fetch origin --tags" then retry.
- Backport generates too many conflicts: "Conflicts are extensive. Consider: (1) resolve manually, or (2) apply fix directly on main and tag from there. Option 2 means main becomes the hotfix source."

---

Phase 9: Post-Deployment Monitoring

After the hotfix is deployed:
- "Hotfix v[next-patch] is live. Monitor for:"
  - The fixed bug not reappearing
  - No new bugs caused by the fix (regression check)
  - Player feedback on the fix

Ask: "Should I create a regression test to prevent this bug from coming back?"

---

Phase 10: Root Cause Analysis (for CRITICAL bugs)

If the hotfix was for a CRITICAL bug, do a brief RCA:
Ask: "What allowed this bug to reach production?"
Common answers:
- "No test coverage for that path" → "Add a test"
- "Edge case not considered in design" → "Update the GDD"
- "Missed during code review" → "Update code review checklist"

Document the RCA in the hotfix file.

---

Edge Cases

- No git available: "Git is required for the hotfix workflow. Please install git or use the development branch workflow instead."
- Force push required: Never force push to shared branches. Use new branches.
- Same bug already fixed on main but not released: "This bug is already fixed on main. The proper solution is to release a new version from main, not a hotfix from the tag."
- User wants multiple fixes in one hotfix: "Hotfixes should fix ONE bug. Multiple fixes = multiple hotfix branches. Combine only if they share a root cause."

---

Phase 11: Communication

If the hotfix affects players (not just internal):
- "Should we communicate this hotfix to players? Options:"
  1. "Patch notes on store page (Steam/Itch)"
  2. "Social media post"
  3. "In-game notification (if supported)"
  4. "No communication needed (internal fix)"

If yes: draft a brief player notice:
"v[next-patch] is live. Fixes: [bug desc]. No breaking changes."

---

Phase 12: Prevention

After the hotfix is deployed and monitored:
- "This bug happened because [root cause]. To prevent recurrence:"
  - [ ] Add test for this scenario
  - [ ] Add code review check for [pattern]
  - [ ] Update design doc to cover this edge case

Ask: "Should I create stories for these prevention items?"

---

Edge Cases (continued)

- Hotfix branch conflicts with ongoing work: "The hotfix branch diverges from main. Coordinate with the team before cherry-picking."
- User wants to revert a hotfix: "Hotfix reverts follow the same process: branch from tag, revert, tag, push, backport."
- Multiple systems need fixing: "File separate bugs. Fix the HIGHEST severity first. Then re-evaluate if other fixes still needed."
