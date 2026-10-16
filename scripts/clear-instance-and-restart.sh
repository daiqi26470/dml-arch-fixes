#!/bin/bash
set -e
AC_DB="ac-database"
WS="ac-worldserver"
echo "Truncating instance tables..."
docker exec -i $AC_DB mysql -uroot -p"password" acore_characters -e "
TRUNCATE TABLE character_instance;
TRUNCATE TABLE instance;
TRUNCATE TABLE instance_reset;
TRUNCATE TABLE account_instance_times;"
echo "Restarting $WS..."
docker restart $WS
