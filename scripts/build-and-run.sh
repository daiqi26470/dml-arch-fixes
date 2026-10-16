#!/bin/bash
set -e
DEST="${1:-/home/dml/games/wow-server-playerbots}"
cd "$DEST"
echo "  [1/3] Register mod-clear-restart..."
MODULES_CMAKE="$DEST/modules/CMakeLists.txt"
if ! grep -q "mod-clear-restart" "$MODULES_CMAKE"; then
    sed -i '/foreach(SOURCE_MODULE ${MODULES_MODULE_LIST})/a\  if (SOURCE_MODULE MATCHES "mod-clear-restart")\n    set(${MODULE_MODULE_VARIABLE} "static")\n  endif()' "$MODULES_CMAKE"
fi
echo "  [2/3] Building (30-60 min)..."
nohup docker compose build ac-worldserver > /tmp/dml-build.log 2>&1 &
disown
echo "  [3/3] Starting..."
docker compose up -d
echo "  Wait 60s, then: docker logs ac-worldserver"
