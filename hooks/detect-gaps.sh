#!/bin/bash
# Gap detection hook: scans for missing artifacts after phase transitions.
# HMGS equivalent: gate-check skill runs gap detection during phase transitions.

echo "[HMGS] detect-gaps: scanning for missing artifacts..."
MISSING=0
for dir in design/gdd design/ux docs/architecture production/sprints production/epics tests; do
    if [ ! -d "$dir" ]; then
        echo "  Missing directory: $dir/"
        MISSING=$((MISSING+1))
    fi
done
if [ $MISSING -eq 0 ]; then
    echo "  All standard directories present."
fi
