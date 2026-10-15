#!/bin/bash
# clear-instance-and-restart.sh
# Directly truncate instance tables and restart worldserver.
# This is the equivalent of `.instance reset` from mod-ale Lua,
# but uses pure SQL + bash. No mod-ale needed.

set -e

AC_DB="ac-database"
WORLDSERVER="ac-worldserver"

echo "========================================"
echo " Instance Clear + Server Restart"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================"
echo ""

echo "=== BEFORE: row counts ==="
docker exec -i $AC_DB mysql -uroot -p"password" acore_characters -e "
SELECT 'character_instance' AS tbl, COUNT(*) AS n FROM character_instance
UNION ALL SELECT 'instance', COUNT(*) FROM instance
UNION ALL SELECT 'instance_reset', COUNT(*) FROM instance_reset
UNION ALL SELECT 'account_instance_times', COUNT(*) FROM account_instance_times;"

echo ""
echo "=== Truncating 4 instance tables ==="
docker exec -i $AC_DB mysql -uroot -p"password" acore_characters -e "
TRUNCATE TABLE character_instance;
TRUNCATE TABLE instance;
TRUNCATE TABLE instance_reset;
TRUNCATE TABLE account_instance_times;
SELECT 'DONE - all 4 instance tables truncated' AS status;"

echo ""
echo "=== AFTER: row counts ==="
docker exec -i $AC_DB mysql -uroot -p"password" acore_characters -e "
SELECT 'character_instance' AS tbl, COUNT(*) AS n FROM character_instance
UNION ALL SELECT 'instance', COUNT(*) FROM instance
UNION ALL SELECT 'instance_reset', COUNT(*) FROM instance_reset
UNION ALL SELECT 'account_instance_times', COUNT(*) FROM account_instance_times;"

echo ""
echo "=== Restarting $WORLDSERVER ==="
docker restart $WORLDSERVER
echo "Restart issued. Waiting 25s for boot..."

sleep 25

echo ""
echo "=== Server status ==="
docker ps -a 2>&1 | grep $WORLDSERVER

echo ""
echo "=== Done. Players should reconnect to find all instance progress reset. ==="
echo "========================================"
