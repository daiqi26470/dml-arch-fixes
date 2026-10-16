# Credits

This repository is a **patch collection / configuration overlay** for
[dads-mmo-lab/dads-mmo-lab](https://github.com/DadsMmoLab/dads-mmo-lab)
running on [AzerothCore 3.3.5a](https://github.com/azerothcore/azerothcore)
with the [liyunfan1223/mod-playerbots](https://github.com/liyunfan1223/mod-playerbots)
Playerbot fork.

## Upstream Projects (all credits to their original authors)

### Core
- **AzerothCore** (GPL v2) - https://github.com/azerothcore/azerothcore
- **dads-mmo-lab** - https://github.com/DadsMmoLab/dads-mmo-lab

### Modules (cloned from upstream by install.sh)

| Module                         | Upstream                                                              |
|--------------------------------|-----------------------------------------------------------------------|
| mod-ah-bot-plus                | https://github.com/NathanHandley/mod-ah-bot-plus                     |
| mod-dungeon-master             | https://github.com/InstanceForge/mod-dungeon-master                  |
| mod-individual-progression     | https://github.com/ZhengPeiRu21/mod-individual-progression          |
| mod-instance-reset             | https://github.com/azerothcore/mod-instance-reset                    |
| mod-multibot-bridge            | https://github.com/Wishmaster117/mod-multibot-bridge                 |
| mod-optimal-bot-raid           | https://github.com/barnaclebarry/mod-optimal-bot-raid                |
| mod-player-bot-level-brackets  | https://github.com/DustinHendrickson/mod-player-bot-level-brackets  |
| mod-playerbots (new fork)      | https://github.com/liyunfan1223/mod-playerbots                      |
| mod-profession-progression     | https://github.com/TopHatMan/mod-profession-progression             |

### My new module
- **mod-clear-restart** - C++ GM command `.clearrestart`. Licensed GPL v2.

## Patches (mine)
- **Round 1-3**: mod-clear-restart C++20 chat-command API
- **Round 4-10**: PascalCase field renames (30+ fields)
- **Round 11-14**: MoveKnackbackFrom 5->4, IsBot removed, docker-compose

## License
- Each upstream module retains its original LICENSE.
- My patches are released under GPL v2 (matching AzerothCore).
