#!/bin/bash
set -e
DEST="${1:-/home/dml/games/wow-server-playerbots}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Installing modules into $DEST/modules..."
while IFS='|' read -r name url branch; do
    [ -z "$name" ] && continue
    [ "${name:0:1}" = "#" ] && continue
    if [ -d "$DEST/modules/$name" ]; then
        echo "  (skip) $name"
        continue
    fi
    echo "  clone $name..."
    git clone --depth=1 --branch "$branch" "$url" "$DEST/modules/$name" 2>&1 | tail -1
done < "$SCRIPT_DIR/modules.list"
echo "  install mod-clear-restart (mine)..."
cp -r "$SCRIPT_DIR/modules/mod-clear-restart" "$DEST/modules/"
bash "$SCRIPT_DIR/scripts/apply-patches.sh" "$DEST"
[ -f "$SCRIPT_DIR/install/worldserver.conf.additions" ] && cat "$SCRIPT_DIR/install/worldserver.conf.additions" >> "$DEST/env/dist/etc/worldserver.conf" 2>/dev/null
echo "  ok Modules installed"
