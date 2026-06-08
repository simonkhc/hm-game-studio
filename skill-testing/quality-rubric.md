# Skill Testing — Quality Rubric

## Gate Category
- [ ] Reads review-mode.txt or uses --review flag
- [ ] Verdict keyword present (PASS/CONCERNS/FAIL or APPROVE/CONCERNS/REJECT)
- [ ] Does not auto-advance without user confirmation
- [ ] Lists specific failed items with remediation

## Review Category
- [ ] Read-only (does not modify artifacts)
- [ ] 8-section GDD check present (for design-review)
- [ ] Verdict keyword present
- [ ] Specific issues referenced by file path

## Authoring Category
- [ ] Section-by-section walkthrough
- [ ] "May I write this to [path]?" before writing
- [ ] Skeleton file created before filling content
- [ ] Writes after each section approval

## Pipeline Category
- [ ] Reads upstream dependencies first
- [ ] Handoff path is clear (output files named)
- [ ] Validates before declaring done

## Analysis Category
- [ ] Read-only (no unexpected writes)
- [ ] Verdict keyword present
- [ ] Specific findings with severity

## Team Category
- [ ] All required agents listed and spawned
- [ ] Blocked agents surfaced immediately
- [ ] Integration step present

## Sprint Category
- [ ] Reads sprint data
- [ ] Status keywords present
- [ ] Velocity/blockers surfaced

## Utility Category
- [ ] Passes static structure checks
