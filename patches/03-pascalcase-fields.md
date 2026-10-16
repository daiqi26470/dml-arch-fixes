# PascalCase field renames (30+ fields)

Run `bash scripts/apply-patches.sh` after cloning modules. The script
reads `PlayerbotAIConfig.h` from the cloned mod-playerbots and converts
every `sPlayerbotAIConfig.camelCase` -> `sPlayerbotAIConfig.PascalCase`.

Also handles:
- `PlayerbotAIConfig::instance()` -> `Instance()` (static method)
- `Instance().X` (chain form) -> `Instance().X` (Pascal)
