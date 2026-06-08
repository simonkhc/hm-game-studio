#!/bin/bash
# Pre-compact hook: saves session state before context compaction.
# HMGS equivalent: skills write output artifacts incrementally.

echo "[HMGS] pre-compact: saving session state..."
PRODUCTION_DIR="production/session-state"
if [ -d "$PRODUCTION_DIR" ]; then
    echo "Session state preserved at $PRODUCTION_DIR/active.md"
fi
