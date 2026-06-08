name: ux-review
description: Review UX specs for clarity, completeness, and accessibility. Check all states covered, interactions mapped, accessible.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: ux-designer

UX Review — Specification Validation

Reviews UX specs to ensure they're complete, clear, and accessible.

---

Phase 1: Read Spec

Read the UX spec from design/ux/[screen-name].md.

Phase 2: Check Completeness

Does the spec have:
- [ ] Player need clearly stated
- [ ] Layout zones defined
- [ ] All states covered (default, hover, active, disabled, error, empty, loading)
- [ ] Interaction map complete
- [ ] Data requirements listed
- [ ] Accessibility checklist

Phase 3: Usability Heuristics

Check against Nielsen's heuristics:
- Visibility of system status: does the screen show what's happening?
- Match with real world: does the screen use familiar patterns?
- User control: can users undo/cancel actions?
- Consistency: does this screen follow the same patterns as other screens?
- Error prevention: are destructive actions protected?
- Recognition: are elements recognizable, not requiring memorization?

Phase 4: Verdict

APPROVED: All checks pass.
CHANGES REQUESTED: Specific issues to fix.
REJECTED: Major gaps — must rewrite before implementation.

Phase 5: Usability Heuristics Check
Apply Nielsen's 10 heuristics:
1. Visibility of system status: does the screen show what's happening?
2. Match between system and real world: are patterns familiar?
3. User control and freedom: can actions be undone?
4. Consistency and standards: same patterns as other screens?
5. Error prevention: are destructive actions protected?
6. Recognition over recall: are elements recognizable without memorization?
7. Flexibility and efficiency: shortcuts for power users?
8. Aesthetic and minimalist design: no irrelevant information?
9. Help users recognize errors: clear error messages?
10. Help and documentation: is help accessible?

Flag any heuristic that fails.

---

Phase 6: Accessibility Check
- Color contrast: sufficient for WCAG AA?
- Font sizes: at least 16px for body text?
- Touch targets: at least 44x44px?
- Keyboard navigation: tab order logical?
- Screen reader: labels on all interactive elements?

Phase 7: Report
Present findings as:
"UX Review: [screen]
- Foundations: [PASS/CONCERNS/FAIL]
- States coverage: [PASS/CONCERNS]
- Interaction clarity: [PASS/CONCERNS]
- Accessibility: [PASS/CONCERNS]
- Heuristics: [N] passed, [N] flagged
Verdict: [APPROVED / CHANGES REQUESTED / REJECTED]"

---

Phase 6: Interaction Flow Check

Beyond individual screens: how do screens connect?
- Does Screen A lead to Screen B logically?
- Are there dead ends? (Screen from which the player can't navigate away)
- Is the back/cancel path always available?

If the UX spec includes a flow diagram: verify it. If not: ask "How do screens connect to each other?"

---

Phase 7: Loading and Empty States

Critical but commonly forgotten states:
- Loading: what does the player see while data loads?
- Empty: what does the screen look like with no data? (empty inventory, no messages, no plants)
- Error: what happens when data fails to load?
- Offline: what happens when network is unavailable?

Any of these missing: flag as GAP.

---

Phase 8: Report Summary

Present:
"UX Review: [screen]
- Completeness: [PASS / CONCERNS / FAIL] — [N] sections missing
- Heuristics: [PASS / CONCERNS] — [N] concerns
- Accessibility: [PASS / CONCERNS / FAIL] — [N] issues
Verdict: [APPROVED / CHANGES REQUESTED / REJECTED]

Key findings:
1. [Top finding]
2. [Second finding]
3. [Third finding]"

---

Edge Cases (continued)

- Screen has too many elements: "This screen has [N] interactive elements. Cognitive load is high. Consider splitting into multiple screens or using progressive disclosure."
- Colors used as the only indicator of state: "Color-blind players won't see the difference. Add icons or text labels alongside color."

---

Phase 9: Comparison with Existing Screens

If multiple UX specs exist: compare for consistency.
"Do all screens use the same button style? Same navigation pattern? Same terminology?"
Inconsistencies to flag:
- Yes/No vs OK/Cancel vs Confirm/Deny
- Different button placements for the same action across screens
- Different terminology for the same concept

---

Phase 10: Edge Cases per Screen

For the specific screen being reviewed, ask about these edge cases:
- "What if the player opens this screen for the first time?" (onboarding state)
- "What if the player has 1000 items?" (scrolling, pagination, search)
- "What if the player has 0 items?" (empty state already covered)
- "What if the network fails?" (offline state)
- "What if the data is still loading?" (loading state)

Any not addressed: flag as GAPS.

---

Edge Cases (continued)

- Platform-specific UX: "This screen needs different layouts for mobile (touch) vs desktop (mouse/keyboard). Is that addressed?"
- Very long content: "Content longer than the screen height needs scrolling or collapse sections."
- Internationalization: "Text length varies per language. German text is often 30% longer than English. Does the layout accommodate this?"
