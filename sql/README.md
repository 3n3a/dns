# sql

## postgres help

| desc | link |
| --- | --- |
| general article about gin indexes in postgres | https://pganalyze.com/blog/gin-index |
| text search functions and operators | https://www.postgresql.org/docs/current/functions-textsearch.html |
| tables and indexes for full text search | https://www.postgresql.org/docs/current/textsearch-tables.html |
| controlling full text search | https://www.postgresql.org/docs/current/textsearch-controls.html |
| format numbers human-readable | https://www.postgresql.org/docs/current/functions-formatting.html |

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

