# Round 14: SQL schema fix

The new DB image requires a few SQL patches before ac-db-import succeeds.
The installer applies them via `scripts/apply-patches.sh`.

If you still see "ac-db-import exit 1" after install, check:
- `docker logs ac-db-import` for the SQL error
- Apply the fix manually (e.g. `TRUNCATE TABLE ...`)
