# sql

## postgres help

| desc | link |
| --- | --- |
| general article about gin indexes in postgres | https://pganalyze.com/blog/gin-index |
| text search functions and operators | https://www.postgresql.org/docs/current/functions-textsearch.html |
| tables and indexes for full text search | https://www.postgresql.org/docs/current/textsearch-tables.html |
| controlling full text search | https://www.postgresql.org/docs/current/textsearch-controls.html |
| format numbers human-readable | https://www.postgresql.org/docs/current/functions-formatting.html |
| unlogged tables in postgres | https://www.crunchydata.com/blog/postgresl-unlogged-tables#unlogged-tables-in-postgres-generate-no-wal-and-are-faster-to-update |

## postgres tools

| desc | link |
| --- | --- |
| pgcopydb - automated pg\_dump and pg\_restore | https://github.com/dimitri/pgcopydb |


## postgres (psql) commands

| desc | command |
| --- | --- |
| create full text search (gin) index | ```time psql -U "domains" -c "create index idx_web on domains using gin (to_tsvector('english', value));"``` |
| dump a whole database into a folder | ```time pg_dump -U domains -Fd -f ./domains_full_dump domains``` |
| load data into table without constraints, indexes and default columns | ```time psql -U "domains" -c "\COPY domains_temp_two(value) FROM './all-domains.txt' WITH CSV DELIMITER E'\t' QUOTE E'\b' ENCODING 'UTF8';"``` |
| change table to unlogged | ```time psql -c 'alter table domains set unlogged'``` |
| change table to logged | ```time psql -c 'alter table domains set logged``` |

### fast loading by creating table and minimal wal

* set wal_level to "minimal"
* use this command:
  ```sh
  # set it back afterwards to this
  psql -U postgres -c "SHOW wal_level;"

  # set wal level to minimal
  psql -U postgres -c "ALTER SYSTEM SET wal_level = 'minimal';" && psql -U postgres -c "SELECT pg_reload_conf();"
  ```
* according to the [official docs](https://www.postgresql.org/docs/current/populate.html#POPULATE-COPY-FROM) COPY is fastest when run in a transaction after creating table --> no WAL needs to be written
* example command:
  ```sh
  psql -U postgres -d domains -c "BEGIN; DROP TABLE domains_temp; CREATE TABLE domains_temp (value); COPY domains_temp(value) FROM './all-domains.txt' DELIMITER ',' CSV; COMMIT;"
  ```
* IMPORTANT: if this load fails for some reason, the table will not be created and your progress lost. BUT if it works, its faster because not so much WAL.
* untested by me...
* ---------- AFTER IMPORT FINISHED -----------
* use this command:
  ```sh
  # set wal level to old value
  psql -U postgres -c "ALTER SYSTEM SET wal_level = 'replica';" && psql -U postgres -c "SELECT pg_reload_conf();"
  ```

## settings for pg

* [settings documentation pg](https://www.postgresql.org/docs/current/runtime-config-wal.html)
* [high write load db - crunchydata](https://www.crunchydata.com/blog/tuning-your-postgres-database-for-high-write-loads)

| setting | value |
| --- | --- |
| `max_wal_size` | `SHOW max_wal_size; ALTER SYSTEM SET max_wal_size = '16GB'; SHOW max_wal_size;` |

