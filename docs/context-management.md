# Context Management

**Adapted from CCGS for Hermes Agent**

## Session State File

`production/session-state/active.md` is a living checkpoint. Update after each significant milestone.

**What to record:**
- Current task
- Completed sections/stories
- Key decisions made
- Next section/story
- Any blockers

**After disruption (compaction, new session, crash):**
1. Read `production/session-state/active.md` first
2. Read the file you were working on
3. Continue from the last recorded state

## Incremental Writing

When creating multi-section documents:
1. Write each section to file immediately after approval
2. Completed sections survive crashes and context compactions
3. Previous discussion about written sections can be safely compacted

## Automatic State Detection

When starting a session:
1. Check `production/stage.txt` for current phase
2. Check `production/session-state/active.md` for work-in-progress
3. Use `session_search` to find relevant past session context
