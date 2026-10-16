#!/bin/bash
set -e
DEST="${1:-/home/dml/games/wow-server-playerbots}"
echo "============================================"
echo "  dml-arch-fixes one-click installer"
echo "  Target: $DEST"
echo "============================================"
echo "[1/5] Checking prerequisites..."
for cmd in docker git; do
    command -v $cmd >/dev/null 2>&1 || { echo "ERROR: $cmd not installed"; exit 1; }
done
docker compose version >/dev/null 2>&1 || { echo "ERROR: docker compose not available"; exit 1; }
echo "  ok"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[2/5] Applying WSL config..."
[ -f "$SCRIPT_DIR/install/.wslconfig" ] && [ -w /mnt/c/Users/QI 2>/dev/null ] && cp "$SCRIPT_DIR/install/.wslconfig" /mnt/c/Users/QI/.wslconfig
echo "[3/5] Installing modules + 14 patches..."
bash "$SCRIPT_DIR/scripts/install-mods.sh" "$DEST"
echo "[4/5] Building (30-60 min)..."
bash "$SCRIPT_DIR/scripts/build-and-run.sh" "$DEST"
echo "[5/5] Done!"
echo "  - ac-worldserver: http://localhost:8085"
echo "  - 2000 random bots will login in ~5 min"
