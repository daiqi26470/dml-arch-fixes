# dml-arch-fixes one-click install

## Prerequisites
- Windows 10/11 with WSL2 enabled
- Docker Desktop for Windows
- 8GB+ RAM, 30GB+ free disk

## Steps

```bash
# 1. Clone
git clone https://github.com/daiqi26470/dml-arch-fixes.git
cd dml-arch-fixes

# 2. WSL config (optional, 8GB cap)
cp install/.wslconfig /mnt/c/Users/QI/.wslconfig
wsl --shutdown
wsl -d Ubuntu

# 3. Install
sudo bash install.sh
```

The installer will:
1. Clone 9 upstream modules
2. Drop in `mod-clear-restart` (my GM command module)
3. Apply 14 rounds of compatibility patches
4. Build worldserver image (30-60 min)
5. Start containers

## In-game commands

| Command             | What it does                                       |
|---------------------|----------------------------------------------------|
| `.clearrestart`     | Truncate 4 instance tables + restart worldserver   |

## License
GPL v2. See CREDITS.md for upstream attributions.
