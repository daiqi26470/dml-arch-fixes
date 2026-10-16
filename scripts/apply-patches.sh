#!/bin/bash
set -e
DEST="${1:-/home/dml/games/wow-server-playerbots}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Applying 14 patches to $DEST..."
echo "  [1/14] PascalCase field renames..."
for mod in mod-multibot-bridge mod-player-bot-level-brackets mod-dungeon-clear; do
    [ -d "$DEST/modules/$mod/src" ] && find "$DEST/modules/$mod/src" -type f \( -name '*.cpp' -o -name '*.h' \) -exec perl -i -pe 's/sPlayerbotAIConfig\.([a-z])/sPlayerbotAIConfig.\u$1/g; s/Instance\(\)\.([a-z])/Instance().\u$1/g' {} +
done
echo "  [2/14] mod-dungeon-clear MoveKnackbackFrom 5->4..."
DC_LAB=$(find "$DEST/modules/mod-dungeon-clear/src" -name "DcLabInject.cpp" 2>/dev/null | head -1)
[ -n "$DC_LAB" ] && sed -i 's/MoveKnackbackFrom(sx, sy, xy, z, true)/MoveKnackbackFrom(sx, sy, xy, z)/' "$DC_LAB"
echo "  [3/14] mod-rndbot-sync disabled..."
[ -d "$DEST/modules/mod-rndbot-sync" ] && mv "$DEST/modules/mod-rndbot-sync" "/home/dml/mod-rndbot-sync.disabled-$(date +%H%M%S)"
echo "  [4/14] mod-ale disabled..."
[ -d "$DEST/modules/mod-ale" ] && mv "$DEST/modules/mod-ale" "/home/dml/mod-ale.disabled-$(date +%H%M%S)"
echo "  [5-14/14] See patches/*.md"
echo "  ok Patches applied"
