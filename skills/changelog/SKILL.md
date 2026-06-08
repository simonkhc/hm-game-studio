name: changelog
description: Generate internal technical changelog from git history since last release tag. Categorize commits by conventional commits (feat/fix/refactor/docs/test/chore). Clean up messages. Flag vague commits. Write to production/releases/changelog-v[VER].md.
allowed-tools: terminal, read_file, write_file, clarify
model: sonnet
agent: release-manager

Changelog — Technical Release Notes

Generates a structured, categorized changelog from git commit history since the last release tag.
Internal-facing — developers and stakeholders read this.

Output: production/releases/changelog-v[VER].md

---

Phase 1: Determine Version Range

Ask: "What version is this changelog for? (e.g., 1.1.0)"
If the project uses git tags: terminal("git tag --list 'v*' | sort -V | tail -5")
Read the previous tag name. Range = previous_tag..HEAD.

If no tags exist: range = initial commit..HEAD. Note: "No previous release tags — full project history."
If this is the first release: "Initial release — including all history."

---

Phase 2: Collect and Classify Commits

terminal("git log --oneline --no-decorate [range]")
If output is empty: "No new commits since last release. Nothing to changelog."
If output is very long (>100 commits): "Found [N] commits since last release. Listing the most significant changes."

Classify each commit by its prefix (conventional commits format):

| Prefix | Category | Include in changelog? |
|---|---|---|
| feat: | Added | YES — these are new features |
| fix: | Fixed | YES — bug fixes |
| refactor: | Changed | YES — if noticeable to developers |
| docs: | Documentation | NO — unless it's API docs release |
| test: | Testing | NO — internal quality |
| chore: | Maintenance | NO — unless build system changes |
| style: | Changed | NO — formatting only |
| perf: | Changed | YES — performance improvements |
| (no prefix) | Other | REVIEW — ask user to categorize |

For each YES commit, clean up the message:
- Remove the prefix: "feat: add watering animation" → "Add watering animation"
- Capitalize first letter
- Remove trailing periods
- If the message is vague ("fix stuff", "update", "wip"): flag as "[vague commit — needs clarification]"

---

Phase 3: Write Changelog

Write to production/releases/changelog-v[VER].md:

```
# Changelog v[VER]

**Date:** [YYYY-MM-DD]
**Previous release:** [vPREV] (or "Initial release")
**Commits:** [N] since last release

## Added
- [cleaned commit messages for feat: commits]

## Fixed
- [cleaned commit messages for fix: commits]

## Changed
- [cleaned commit messages for refactor:, perf:, style: commits]

## Deprecated
- [if any deprecation notices]

## Notes
- [any special notes about this release]

## Full Commit History
[raw git log for reference — or "See git log for full history"]
```

---

Phase 4: Post-Checks

- All YES-categorized commits are included (none skipped)
- Vague commits are flagged with "[needs clarification]"
- Ask: "Should I also generate player-friendly patch notes from this changelog?"

---

Edge Cases

- No git repository: "No git history found. Changelogs are best generated from version control. Consider initializing git."
- Commit messages are all "wip" or "fix": "Commit quality is low. Suggest using conventional commits (feat:, fix:, refactor:) for better changelog generation."
- Merge commits in history: Skip merge commits. They duplicate individual commit messages.
- Binary files changed: Skip. "Binary asset changes not listed — refer to asset changelog if needed."

---

Phase 5: Breaking Changes Detection

If this release has breaking changes (save format, API, system behavior):
- Scan commit messages for "BREAKING CHANGE" or "!" after prefix (feat!:)
- Scan changed files in save-related paths
- Flag: "⚠️ BREAKING CHANGES detected: [list]. Add migration notes."

If breaking changes exist, add a WARNING section to the changelog:
- "⚠️ Save files from v[previous] are NOT compatible with v[current]"
- "⚠️ API changes: [list of changed interfaces]"
- "How to migrate: [instructions]"

---

Phase 6: Release Notes Handoff

After writing the changelog:
- "Changelog written to production/releases/changelog-v[VER].md"
- "This is the TECHNICAL changelog (developer-facing)."
- Ask: "Should I also generate player-facing patch notes?"
  If yes: read changelog, translate to player language, write to patch-notes file.

---

Phase 7: Cross-Reference with Bug Tracker

If bugs are tracked in production/bugs/:
- Search for bugs fixed in this release range by matching fix commit descriptions
- Verify: every bug marked as Fixed in the tracker has a corresponding changelog entry
- If a bug is fixed but not in changelog: add it to the Fixed section

---

Edge Cases

- No commits found: "No changes since last release. Empty changelog."
- Repository is very large (5000+ commits): "Large history. Consider release-based filtering or using only squash-merge commits."
- Binary files are the only changes: "Only asset changes — not typically changelogged. Consider if the changelog is needed."
- User wants changelog for unreleased work: "I can only generate from committed work. Please commit your changes first."

---

Phase 8: Consistent Formatting Rules

Before writing the final file, apply these formatting rules:
1. Each entry starts with a capital letter and ends without a period
2. Entries are sorted alphabetically within each category (Added, Fixed, Changed)
3. No duplicate entries (same change in multiple commits → merge into one)
4. Each entry is one line, unless it needs explanation (add a sub-bullet)
5. Reference issue/bug numbers where applicable: "Fixed crash on save (bug-#42)"

---

Phase 9: Post-Write Verification

After writing the changelog file:
- Count entries: "Added: [N], Fixed: [N], Changed: [N]"
- Verify: no entry says "wip" or "temp" or "fix later"
- Verify: at least 1 entry exists in a non-empty changelog
- If the changelog is empty (no feat/fix/refactor/perf commits): write a single entry: "Maintenance release — no new features or fixes."

---

Edge Cases (continued)

- Commit message references an issue that doesn't exist: "Commit [hash] references #[N] but no such issue exists. Remove the reference or create the issue."
- Multiple authors for the same change: "Co-authored commits are supported. Mention both authors in the changelog credits."
