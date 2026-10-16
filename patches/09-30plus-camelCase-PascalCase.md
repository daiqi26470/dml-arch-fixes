# Round 10: 30+ camelCase fields

Bulk regex:
- `sPlayerbotAIConfig\.([a-z])` -> `sPlayerbotAIConfig.\u$1`
- `Instance\(\)\.([a-z])` -> `Instance().\u$1`

See `scripts/apply-patches.sh` for the implementation.
