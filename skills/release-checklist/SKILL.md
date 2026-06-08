name: release-checklist
description: Generates a comprehensive pre-release checklist covering build verification (per platform), content completeness, save compatibility, store metadata, legal, and release infrastructure. Tailored to project's engine and platforms. Produces a trackable document with PASS/FAIL per item.
allowed-tools: read_file, write_file, terminal, clarify, search_files
model: sonnet
agent: release-manager

Release Checklist — Pre-Release Validation

Generates a structured release checklist document for the upcoming version. Each item is checkable (PASS/FAIL/NA). The checklist is worked through item by item before launch.

Output: production/releases/release-v[VER]-checklist.md

---

Phase 1: Determine Version

Ask: "What version are we releasing? (e.g., 1.0.0, 1.1.0, 0.9.0-beta)"
If the project uses git tags: terminal("git tag --list 'v*' | sort -V | tail -3") — suggest next version.
Read project.godot (or equivalent Unity/Unreal project settings) for current version string.
If the file exists and has a version: "Project settings say [version]. Confirm?"

If project has no versioning yet: use semantic versioning. "First release = 1.0.0."

---

Phase 2: Identify Platforms

Ask: "What platforms are we releasing on?"
Platforms: Windows, macOS, Linux, Web (HTML5), Android, iOS, Nintendo Switch, PlayStation, Xbox.
For each platform selected, generate separate checklist items.

If the user says "all platforms": only generate for platforms the engine supports.
(Godot: Windows, macOS, Linux, Web, Android, iOS. Unity: all. Unreal: all.)

---

Phase 3: Generate Checklist Sections

3a. Build verification (per platform)

For EACH target platform:
- [ ] [Platform] builds without errors
- [ ] [Platform] launches without crash
- [ ] [Platform] main scene loads within [N] seconds
- [ ] [Platform] performance meets targets (FPS, memory)
- [ ] [Platform] input works correctly (keyboard, mouse, touch, gamepad)

Attempt automated build if engine CLI is available:
- Godot: terminal("godot --headless --export-release [platform] 2>&1")
- Unity: terminal("[unity] -batchmode -buildTarget [platform] -projectPath . -logFile build.log")
- If build fails: mark FAIL, capture the error output, suggest the likely fix.

3b. Content completeness
- [ ] All scenes load without errors
- [ ] All audio files play correctly (no missing references)
- [ ] All UI text is visible with no truncation at target resolution
- [ ] All localization strings are present (per locale)
- [ ] No missing textures/models (no pink/missing-material placeholders)

3c. Save compatibility
- [ ] Save files from previous version load correctly
- [ ] If save format changed: migration path works
- [ ] Corrupted save files are handled gracefully (show error, not crash)
- [ ] Save file is written to correct platform-specific location

3d. Store metadata (per store platform)
- [ ] Game title and short description written
- [ ] Full description written (supports markdown/basic formatting)
- [ ] At least 4 screenshots captured, show key gameplay moments
- [ ] Gameplay trailer or video (30-90 seconds) prepared
- [ ] Category and tags selected (match store taxonomy)
- [ ] Age rating obtained (ESRB, PEGI, USK, etc. per region)
- [ ] Price set (or marked as free)

3e. Legal
- [ ] EULA written and included in build
- [ ] Privacy policy written (required for any online functionality)
- [ ] Credits complete (all team members, third-party assets, libraries)
- [ ] Third-party licenses documented (include license texts)
- [ ] Open source attribution (if using GPL/LGPL/MIT libraries)

3f. Release infrastructure
- [ ] Git tag created: v[version]
- [ ] Build artifacts archived (versioned, accessible)
- [ ] Distribution platform configured (Steam, Itch.io, App Store, etc.)
- [ ] Rollback plan documented (how to revert if launch goes wrong)
- [ ] Post-launch monitoring plan (crash reporting, analytics)

---

Phase 4: Write Checklist

Write to production/releases/release-v[VER]-checklist.md:

```
# Release Checklist v[VER]

**Target date:** [YYYY-MM-DD]
**Platforms:** [list]
**Engine version:** [from technical-preferences.md]

## Build Verification
- [ ] [Platform 1] — PASS/FAIL — [notes if failed]
- [ ] [Platform 2] — PASS/FAIL

## Content
- [ ] All scenes load — PASS/FAIL
- [ ] All audio present — PASS/FAIL

## Save Compatibility
[Items from 3c]

## Store & Legal
[Items from 3d-3e]

## Infrastructure
[Items from 3f]

## Sign-off
**Release manager:** ________________
**Date:** ________________
**GO / NO-GO:** ________________
```

---

Phase 5: Post-Checks

- File written to production/releases/release-v[VER]-checklist.md
- User has an actionable checklist they can work through
- Ask: "Would you like to start working through the build verification items now?"
- If the user has a CI/CD pipeline: "Can I help set up automated checks for the build verification items?"

Phase 6: Version-Specific Notes

Ask: "Any version-specific notes for this release?"
Examples:
- "Breaking save format change — warn players"
- "First release on a new platform"
- "Beta release — expect bugs"

Add a Notes section to the checklist if applicable.

---

Edge Cases

- No build tool available: "Build environment not detected. Manual build verification required."
- Single platform release: Generate single-platform checklist. Skip multi-platform sections.
- User changes version during process: Update version string in all files. Check for version references in code.
- First release ever: Add extra items: "First-time store setup", "Developer account created", "Tax/Payment info submitted".
