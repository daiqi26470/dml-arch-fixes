# mod-ale disabled

The new mod-playerbots fork of AzerothCore removed public IsBot() helpers
and changed the chat-command C++ API. mod-ale does not compile against
the new core.

**Replacement:** use `scripts/clear-instance-and-restart.sh` from this
repo (truncates instance tables, then docker restarts ac-worldserver).
