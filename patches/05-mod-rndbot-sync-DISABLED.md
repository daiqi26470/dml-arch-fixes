# mod-rndbot-sync disabled

The new playerbot fork removed:
- `WorldSession::IsBot()`
- `Player::IsBot()`
- `PlayerbotAI::IsBot()`
- `sRandomPlayerbotMgr->IsPlayerBot()`
- `sPlayerbotsMgr->IsPlayerBot()`

There is no public API to ask "is this player a bot" in the new fork.
Module kept disabled. Random bots stay at the default 1-80 spread.
