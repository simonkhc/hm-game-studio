#!/bin/bash
# Notification hook: sends desktop notifications for long-running tasks.
# HMGS equivalent: Hermes runs synchronously — no notification needed.

echo "[HMGS] notify: task complete."
if command -v notify-send &> /dev/null; then
    notify-send "HMGS" "Task complete: $1"
elif command -v osascript &> /dev/null; then
    osascript -e "display notification "$1" with title "HMGS""
fi
