name: balance-check
description: Analyze game balance by reading GDD formulas and config data files. Checks damage curves, economy flows, difficulty progression. Compares config values against GDD-specified safe ranges. Reports BROKEN/CONCERN/WARNING level issues.
allowed-tools: read_file, search_files, write_file, patch, clarify
model: sonnet
agent: economy-designer

Balance Check — Game Balance Analysis

Reviews configurable game data against GDD formulas to identify balance issues before they reach players.
The goal: catch imbalances that would make the game too easy, too hard, or economically broken.

This skill is READ-ONLY by default. It can optionally apply fixes.

---

Phase 1: Read Balance-Relevant GDDs

Search design/gdd/*.md.
For each file, search for sections containing "## Formulas" or "## Tuning Knobs".
If no GDDs have these sections: "No balance data in GDDs. Add Formulas and Tuning Knobs sections first."

For each GDD with balance data:
- Extract ALL tunable parameters: name, default value, valid range, description
- Extract ALL formulas: variables, formula expression, example calculation
- Note the config file path from the Tuning Knobs section (e.g., "assets/data/garden.json")

---

Phase 2: Read Config Data

For each config file referenced by GDDs, read the actual values:
- Godot: search assets/data/*.json
- Unity: search Assets/Resources/* or ScriptableObjects
- Unreal: search Config/* or DataTables

If the config file doesn't exist: "Config file [path] referenced in GDD but doesn't exist. Create it."
If the config file exists but has different parameters than the GDD specifies: note the missmatch.

For each value in the config file:
- Record: parameter name, actual value, source file path
- Compare against GDD spec: default, min, max

---

Phase 3: Run Balance Checks

3a. Range compliance
For each tunable parameter:
| Config value vs GDD range | Severity | Action |
|---|---|---|
| Within range | OK | None |
| Outside range by <10% | WARNING | "Borderline — may be intentional" |
| Outside range by 10-50% | CONCERN | "Likely a bug — review" |
| Outside range by >50% | BROKEN | "Clearly wrong — fix now" |

3b. Economy balance (if economy GDD exists)
Calculate key economy ratios:
- Faucet rate (how fast resources enter) vs sink rate (how fast they leave)
- If faucet >> sink: inflation — resources become worthless
- If sink >> faucet: deflation — players can never afford anything
- Target: faucet/sink ratio between 0.8 and 1.2 for stable economy

3c. Progression pacing
Calculate time to reach each progression milestone:
- Milestone 1: [N] hours of play
- Milestone 2: [N] hours
- Progression should be exponential-ish (faster early, slowing over time)
- If any milestone takes >2x the previous one: "Pacing spike at milestone [N]"

3d. Difficulty curve (if combat GDD exists)
- Plot player power vs enemy power over time/progress
- If player always stronger: game is too easy
- If enemies always stronger: game is too hard
- Target: player and enemy power should cross periodically (player has advantage, then enemy catches up)

3e. Statistical outlier detection
If numeric data exists across multiple entities (weapons, enemies, items):
- Calculate mean and standard deviation for key stats (damage, health, speed, cost)
- Flag anything >2 standard deviations from mean as potential outlier
- Outlier may be intentional (boss enemy) or accidental (typo in config)

---

Phase 4: Report

```
## Balance Check Report

### BROKEN (must fix)
- [Parameter] in [file]: value=[X], GDD range=[Y-Z]. [Recommendation]

### CONCERNS (should fix)
- [Parameter] in [file]: value=[X], GDD range=[Y-Z]. [Recommendation]

### WARNINGS (review)
- [Parameter] in [file]: borderline. Confirm intentional?

### Economy Health
- Faucet/sink ratio: [N] — [STABLE / INFLATION / DEFLATION]
- Time to first milestone: [N] hours
- Time to max progression: [N] hours

### All values in spec
No issues found. Balance data matches GDD specifications.
```

---

Phase 5: Offer Fixes (Optional)

For BROKEN and CONCERN items:
- Show: current value → recommended value → reason
- Ask: "Should I update [config file] to change [parameter] from [X] to [Y]?"
- If yes: use patch to update the config file
- If no: note the user's reasoning in the report

---

Edge Cases

- Config file doesn't exist yet: "Balance can't be checked without config files. Create at least one config file matching the GDD's Tuning Knobs."
- GDD specifies ranges but not defaults: Flag as INCOMPLETE GDD. "Need default values before balance checking."
- All values differ from GDD intentionally: "Config has diverged from GDD. Either update the GDD to match the config, or update the config to match the GDD. Both should not coexist with different values."

---

Phase 6: Sensitivity Analysis

For parameters marked as CONCERN or WARNING:
Run a simple sensitivity check: what happens if we change this parameter by ±10%?

Example: "If growth_rate changes from 1.0 to 0.9 (-10%), first milestone takes 11% longer (7.7 days instead of 7). That's acceptable. If it changes to 0.5 (-50%), first milestone takes 100% longer (14 days). That's BROKEN."

Document: which parameters are sensitive (small change → big impact) and which are tolerant.

---

Phase 7: Trend Tracking (if previous balance reports exist)

Search docs/balance/review-*.md
If previous reports exist:
- Compare current values against previous values
- If a parameter was flagged before and still flagged: "Parameter [X] has been flagged for [N] consecutive reviews. Still unresolved."
- If values have changed: "Parameter [X] changed from [old] to [new]. Review the reason for change."

---

Phase 8: Recommendations Summary

Based on all checks, produce a ranked list of recommended changes:
1. [Most impactful fix] — fixes [broken item]
2. [Second most impactful] — improves [concern]
3. [Nice to have] — addresses [warning]

Estimated impact of each fix if applicable:
"Fixing [parameter] from [X] to [Y] would [increase/decrease] time-to-milestone by [Z]%."

---

Edge Cases

- Engine version affects calculations: "Some formulas depend on engine physics or timing. Verify the formula assumptions match the actual engine behavior."
- Player skill variability: "Balance assumes average player skill. For wide-skill-range games, add difficulty settings or dynamic difficulty adjustment, not mid-point tuning."
- New content makes old balance obsolete: "When adding new weapons/characters/levels, re-run balance check. New content often shifts the optimal strategy."
