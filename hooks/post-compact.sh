#!/bin/bash
# Post-compact hook: restores session state after compaction.
# HMGS equivalent: read production/session-state/active.md on session start.

echo "[HMGS] post-compact: restoring session context..."
if [ -f "production/session-state/active.md" ]; then
    echo "Session state restored from production/session-state/active.md"
fi
