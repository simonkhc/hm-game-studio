# Phase 7: Release

**Goal:** Ship the game.

## Pipeline

```
Release Checklist → Launch Checklist → Ship
```

## Steps

### Step 1: Release Checklist

Load `hm-game-studio/skills/release-checklist/SKILL.md`. Generate pre-release checklist:
- **Build verification** — all platforms compile and run
- **Certification** — platform-specific requirements
- **Store metadata** — descriptions, screenshots, trailers
- **Legal** — EULA, privacy policy, ratings
- **Save compatibility** — migration path
- **Analytics** — tracking verified

### Step 2: Launch Readiness

Full cross-department validation:
| Department | What's Checked |
|-----------|---------------|
| Engineering | Build stability, crash rates, load times |
| Design | Feature completeness, tutorial flow |
| Art | Asset quality, missing textures |
| Audio | Missing sounds, mixing levels |
| QA | Open bugs by severity, regression pass rate |
| Narrative | Dialogue completeness, lore consistency |
| Localization | All strings translated, no truncation |
| Accessibility | Compliance checklist |
| Store | Metadata complete, screenshots approved |

Each gets Go / No-Go. All must be Go to ship.

### Step 3: Generate Player-Facing Content
- **Patch notes** — player-friendly notes from git history
- **Changelog** — internal technical changelog

### Step 4: Tag and Release
```bash
git tag v1.0.0
git push origin main --tags
```

## Post-Launch

### Hotfix Workflow
1. Create hotfix branch from the release tag
2. Fix, test, verify
3. Tag and release patch
4. Backport fix to main branch

### Post-Mortem
After launch stabilizes:
- What went well
- What went wrong
- What to change next time
- Write to `docs/postmortems/postmortem-v1.md`

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| Release checklist | `production/releases/release-v1-checklist.md` | Required |
| Launch checklist | `production/releases/launch-v1-readiness.md` | Required |
| Patch notes | `production/releases/patch-notes-v1.md` | Recommended |
| Post-mortem | `docs/postmortems/postmortem-v1.md` | Recommended |
