# Round 12: docker-compose volume mount

The container must see `./modules` at `/azerothcore/modules` so
DBUpdater can find the playerbots SQL. See `install/docker-compose.yml`.
