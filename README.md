# dml-arch-fixes

> Patch collection / configuration overlay, NOT a full server source dump.

Contains:
1. Configuration files (docker-compose, worldserver.conf, .wslconfig)
2. 14 rounds of build fixes (see patches/)
3. One new C++ module (mod-clear-restart) - my own work
4. One-click installer that clones upstream modules and applies patches

## Quick start

```bash
git clone https://github.com/daiqi26470/dml-arch-fixes.git
cd dml-arch-fixes
sudo bash install.sh
```

See INSTALL.md for full instructions.

## What this fixes

AzerothCore's Playerbot fork renamed dozens of AIConfig fields and
removed legacy helpers. Most third-party modules don't compile against
it. We fix that.

## Repo layout

```
dml-arch-fixes/
- README.md
- INSTALL.md
- CREDITS.md
- install.sh
- modules.list
- install/
  - .wslconfig
  - docker-compose.yml
  - worldserver.conf.additions
- modules/
  - mod-clear-restart/
- scripts/
  - install-mods.sh
  - apply-patches.sh
  - build-and-run.sh
  - clear-instance-and-restart.sh
- patches/
- FEDORA_SETUP.md
```

## License
GPL v2. See CREDITS.md for upstream attributions.
