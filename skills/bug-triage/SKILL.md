name: bug-triage
description: Review all open bugs in production/bugs/, classify by severity×frequency matrix, prioritize (P0=immediate, P1=today, P2=this sprint, P3=next sprint, P4=backlog), assign to system owners, flag CRITICAL bugs for immediate action.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: qa-lead

Bug Triage — Prioritization and Assignment

Reviews all open bugs in production/bugs/, classifies them by combined severity and frequency, and produces a prioritized action plan with suggested assignments.

This skill is READ-ONLY. It does not modify files.

---

Phase 1: Collect Open Bugs

Search production/bugs/bug-*.md.
If no files found: "No bugs tracked. Quality is clean or bugs aren't being filed."

For each file found, read and extract:
- Bug number (from filename)
- Title (from H1)
- Severity (from Severity field)
- Frequency (from Frequency field)
- Status (from Status field — only "Open" or "Investigating" are active)
- Description (first paragraph after Description heading)

Filter: only bugs with Status == "Open" or Status == "Investigating".
If all bugs are "Fixed" or "Verified" or "Won't Fix": "All known bugs are resolved. Nothing to triage."

---

Phase 2: Prioritize Using Matrix

Sort active bugs by severity × frequency:

| Frequency \ Severity | CRITICAL | HIGH | MEDIUM | LOW |
|---|---|---|---|---|
| Always | P0 | P1 | P2 | P3 |
| Often | P0 | P1 | P2 | P3 |
| Sometimes | P1 | P2 | P3 | P4 |
| Rarely | P2 | P3 | P4 | P4 |

P0 = IMMEDIATE — fix today, pause other work
P1 = TODAY — fix this sprint, high priority
P2 = THIS SPRINT — fix before sprint end
P3 = NEXT SPRINT — schedule after current sprint
P4 = BACKLOG — fix when convenient/deferred

If severity or frequency is missing from a bug report: flag as "INCOMPLETE".
Ask user: "Bug [N] is missing [field]. Can you provide it?"

---

Phase 3: Detect Duplicates and Dependencies

Look for bugs that may be related:
- Same system mentioned in multiple bugs
- Same error message or symptom
- Same reproduction starting point

If Bug A causes Bug B (fixing A would fix B):
- Flag: "Bug [B] may be a symptom of Bug [A]. Fix [A] first, then verify [B]."
- B gets priority: PENDING (blocked on A)

---

Phase 4: Assign

For each P0-P2 bug, suggest an owner based on the affected system:
- Read the bug description to identify which system it affects
- Map to the likely owner using the domain boundaries from agent-coordination-map.md
- If the system is ambiguous: "Bug [N] — unsure which system. Can you help identify the owner?"

Present assignments for user confirmation:
"Bug [N]: [title] → assign to [suggested owner]? [Y/N]"

---

Phase 5: Report

Present the triage results:

```
## Bug Triage Report
**Date:** [date]

### P0: IMMEDIATE ([N] bugs)
- Bug [N]: [title] — [reason it's P0]

### P1: TODAY ([N] bugs)
- Bug [N]: [title] — assign to [owner]

### P2: THIS SPRINT ([N] bugs)
- Bug [N]: [title] — assign to [owner]

### P3: NEXT SPRINT ([N] bugs)
- Bug [N]: [title]

### P4: BACKLOG ([N] bugs)
- Bug [N]: [title]

### Summary
Total open bugs: [N]
P0: [N] — fix now
P1: [N] — fix this sprint
P2-P4: [N] — schedule accordingly
```

---

Phase 6: Offer Immediate Action

For P0 bugs: "Bug [N] is critical. Should I start working on a fix now?"
For P1 bugs with no P0: "P1 bugs should be fixed this sprint. Should I investigate the first one?"
For no P0/P1: "No critical bugs. Ready to focus on feature work."

---

Edge Cases

- No open bugs: Done. "No open bugs. Quality looks good."
- All bugs are P4: "All open bugs are backlog-level. Consider closing very old P4 bugs as Won't Fix."
- Bug report is unreadable (no structure): Flag: "Bug [N] needs restructuring before triage. Ask the reporter to use the bug-report skill."
- Same bug reported 3+ times: Create a meta-bug linking all duplicates. Close duplicates as "Duplicate of bug-[N]".

---

Phase 7: Historical Trending

If this is not the first triage (previous triage notes exist in production/triage/):
- Compare bug count vs last triage: "Bug count went from [N] to [M] since last triage."
- Compare P0 count: "Critical bugs: [N] now vs [M] last time."
- Trend: IMPROVING / STABLE / WORSENING

If WORSENING: "Bug count is increasing. Consider a bug-bashing day or reducing feature work."

---

Phase 8: Recommendations

Based on triage results, suggest process improvements:
- "Multiple bugs in [system] — consider a focused QA pass on that system."
- "Bugs are being filed without severity — remind the team to use the bug-report skill properly."
- "Several P4 bugs are over 3 months old — consider closing as 'Won't Fix' to clean the backlog."

---

Edge Cases

- No bug files exist: Report "No bugs tracked. Either quality is high or bugs aren't being filed. Consider: are we playtesting enough?"
- All bugs are in one system: "Bugs are concentrated in [system]. This system may need architectural review."
- Bug severity doesn't match description: "Bug [N] is classified as LOW but describes a crash. Reclassify as CRITICAL."
- User disagrees with priority: Adjust. The triage is advisory, not authoritative.
