# Phase 6: Polish

**Goal:** The game is feature-complete. Now make it good — performance, balance, accessibility, audio, visual polish, playtesting.

## Pipeline

```
Performance → Balance → Asset Audit → Playtesting → Polish Pass → Gate Check
```

## Steps

### Step 1: Performance Profiling

Load `hm-game-studio/skills/perf-profile/SKILL.md`:
- Establish targets (FPS, memory, load times per platform)
- Profile CPU and GPU (identify hot spots)
- Profile memory (leaks, wasteful allocations)
- Profile loading (streaming, asset bundles)

**Key areas:** Draw calls, physics, AI pathfinding, UI update frequency

### Step 2: Balance Analysis

Load `hm-game-studio/skills/balance-check/SKILL.md`:
- Statistical outliers in damage/economy curves
- Broken progression (dead zones, power spikes)
- Degenerate strategies
- Economy imbalances
- Difficulty curve

Fix values in `assets/data/` config files.

### Step 3: Asset Audit

Load `hm-game-studio/skills/asset-audit/SKILL.md`:
- Naming conventions followed
- File format standards met
- Size budgets respected
- Missing textures/models/sounds
- LOD levels correct

### Step 4: Playtesting (3 Sessions)

Three structured playtesting sessions:
| Session | Focus | Goals |
|---------|-------|-------|
| 1 | New player experience | Can a new player figure it out? |
| 2 | Mid-game systems | Do systems hold up after first hour? |
| 3 | Difficulty curve | Is challenge scaling appropriate? |

Each session produces a playtest report in `production/playtests/`.

### Step 5: Accessibility Audit

Audit against the tier committed in Phase 3:
- **Visual:** Color-blind palettes, font sizes, contrast ratios
- **Motor:** Rebindable controls, adjustable dead zones
- **Cognitive:** Tutorial clarity, visual indicators
- **Auditory:** Visual alternatives for audio cues

### Step 6: Coordinated Polish Pass

Use `delegate_task(tasks=[...])` to coordinate specialists:
1. **Performance optimization** (performance-analyst)
2. **Visual polish** (technical-artist)
3. **Audio polish** (sound-designer)
4. **Feel/juice** — particles, screen shake, animation smoothing

### Step 7: Localization

Scan for:
- Hardcoded strings
- Concatenation that breaks translation
- Text that doesn't account for expansion
- Missing locale files

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| Performance report | `docs/performance/profile-[date].md` | Recommended |
| Balance report | `docs/balance/review-[date].md` | Recommended |
| Playtest reports | `production/playtests/report-[N].md` | Required (3+) |
| Polish log | `docs/polish/polish-pass-[date].md` | Recommended |

## Gate Check

Before advancing to Phase 7:
- [ ] At least 3 playtest reports exist
- [ ] Coordinated polish pass completed
- [ ] No blocking performance issues
- [ ] Accessibility tier requirements met
- [ ] Localization check completed
