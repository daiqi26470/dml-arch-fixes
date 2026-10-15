# dml-arch-fixes

Private patch log of dml-arch Playerbot fork migration (Oct 2026).

## Background

The dml docker image ships the new mod-playerbots/mod-playerbots Playerbot
fork. Its AzerothCore core is on the Playerbot branch which renamed dozens
of AIConfig fields and removed legacy helpers like WorldSession::IsBot().
Most third-party modules were written for the older liiyunfan1223/mod-playerbots
fork and do not compile against the new core.

This repo records the round-by-round fix history so the same set of
patches can be replayed next time someone runs dml-update.

## Fix round log (14 rounds)

| #  | Module                          | Symptom                                                       | Fix |
|----|---------------------------------|---------------------------------------------------------------|-----|
| 1  | mod-ale (cmake)                 | ConfigureALEModule did not link the module                    | Force static linkage. Kept disabled. |
| 2  | mod-clear-restart (new)         | C++20 chat-command API                                         | Use Acore::ChatCommands::ChatCommandTable + const. |
| 3  | mod-clear-restart               | sWorld->SendServerMessage removed                              | Drop the call; ShutdownServ broadcasts. |
| 4  | mod-player-bot-level-brackets   | equipAndSpecPersistence not found                             | PascalCase: EquipAndSpecPersistence. |
| 5  | mod-multibot-bridge             | parsedSpecLinkOrder not found                                 | PascalCase: ParsedSpecLinkOrder. |
| 6  | mod-multibot-bridge             | autoGearCommand not found                                     | PascalCase: AutoGearCommand. |
| 7  | mod-multibot-bridge             | maxAddedBots not found                                        | PascalCase: MaxAddedBots. |
| 8  | (3 modules)                     | PlayerbotAIConfig::instance() static missing                  | PascalCase: Instance(). |
| 9  | mod-rndbot-sync                 | WorldSession::IsBot() / Player::IsBot() all removed            | Disabled module. |
| 10 | (3 modules)                     | 30+ camelCase AIConfig fields missing                         | Bulk regex (fix-all-camelcase.sh). |
| 11 | mod-dungeon-clear               | MoveKnackbackFrom(sx,sy,xy,z,true) 5-arg                      | Drop ", true" (4-arg). Kept disabled. |
| 12 | docker-compose                  | DBUpdater crash on missing mod-playerbots source path         | Mount ./modules into container. |
| 13 | worldserver.conf                | DBUpdater running on every boot                               | Playerbots.Updates.EnableDatabases = 0. |
| 14 | SQL schema                      | DB import exit 1                                              | Manually fixed. |

## New module: mod-clear-restart

In-game GM command .clearrestart:
- Truncates character_instance, instance, instance_reset, account_instance_times
- Broadcasts shutdown message via sWorld->ShutdownServ
- Waits 10s then exits; docker (restart: unless-stopped) brings it back

## Disabled modules

- mod-ale (Lua engine) - use clear-instance-and-restart.sh instead
- mod-rndbot-sync (IsBot API removed)
- mod-dungeon-clear (5-arg MoveKnackbackFrom removed)

## Working modules (12)

mod-ah-bot-plus, mod-clear-restart, mod-dungeon-master,
mod-increased-boss-loot, mod-individual-progression, mod-instance-reset,
mod-multibot-bridge, mod-optimal-bot-raid, mod-player-bot-level-brackets,
mod-playerbots (new fork), mod-profession-progression
