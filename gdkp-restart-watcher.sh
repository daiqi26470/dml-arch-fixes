#!/bin/bash
# gdkp-restart-watcher.sh
# Polls /tmp/gdkp-restart-pending. When the file appears (Lua wrote it
# after a `.instance clear` or `.instance reset`), runs the host restart
# script which truncates the instance tables (no-op if Lua already did) and
# then `docker restart ac-worldserver`.
#
# Usage:
#   bash /mnt/c/Users/QI/.openclaw/workspace/gdkp-restart-watcher.sh
#   # or, to run in the background:
#   nohup bash /mnt/c/Users/QI/.openclaw/workspace/gdkp-restart-watcher.sh \
#     > /tmp/watcher.log 2>&1 &

set -u

MARKER="/tmp/gdkp-restart-pending"
RESTART_SCRIPT="/home/dml/dml-arch/dml-arch-restart.sh"
POLL_INTERVAL=5  # seconds

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "gdkp-restart-watcher started (poll ${POLL_INTERVAL}s, marker ${MARKER})"

# Ensure the restart script exists
if [ ! -x "$RESTART_SCRIPT" ]; then
    log "ERROR: $RESTART_SCRIPT not found or not executable. Watcher exiting."
    exit 1
fi

while true; do
    if [ -f "$MARKER" ]; then
        kind=$(head -1 "$MARKER" 2>/dev/null | cut -d: -f1)
        log "Restart marker found (kind=$kind). Running restart script..."
        rm -f "$MARKER"
        if bash "$RESTART_SCRIPT"; then
            log "Restart script finished. Waiting 60s for server to come back up."
            sleep 60
        else
            log "Restart script exited with non-zero status. Will not retry."
        fi
    fi
    sleep "$POLL_INTERVAL"
done