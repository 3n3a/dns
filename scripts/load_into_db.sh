#!/bin/bash
#
# load exported domains
# into database (pg)
#

FILE_PATH="$1"
DB_CONN="$2"

psql "$DB_CONN" -f "$FILE_PATH"
