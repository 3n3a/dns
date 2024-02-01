#!/bin/bash
#
# remote toolkit
#
# env variables needed
#
# SSH_HOST
# SSH_PATH
# CONTAINER_NAME
# DB_USER
#

copy_to_server() {
	src_file="$1"

	# supports only connections via ssh public key
	scp "$src_file" "$SSH_HOST:$SSH_PATH"
}

remote_psql_command() {
	cmd="$1"

	ssh -T "$SSH_HOST" "docker exec $CONTAINER_NAME /bin/bash -c \"psql -U $DB_USER -A -t -c '$cmd'\""
}

set_wal_level_minimal() {
	# set it back afterwards to this
	remote_psql_command "SHOW wal_level;"

	# set wal level to minimal
	remote_psql_command "ALTER SYSTEM SET wal_level = 'minimal';"
	remote_psql_command "SELECT pg_reload_conf();"
}

set_wal_level_replica() {
	# set wal level to old value
	remote_psql_command "ALTER SYSTEM SET wal_level = 'replica';"
	remote_psql_command "SELECT pg_reload_conf();"
}

run_sql() {
	sql_file="$1"
	sql_cmds=$(cat "$sql_file")

	remote_psql_command "$sql_cmds"
}