#!/bin/bash
#
# remote toolkit
#
# env variables needed
#
# SSH_HOST
# SSH_PATH
# DB_CONN
# CONTAINER_NAME
#

copy_to_server() {
	src_file="$1"

	# supports only connections via ssh public key
	rsync -v "$src_file" "$SSH_HOST:$SSH_DEST"
}

wait_postgres() {
	return_code=$(ssh -T "$SSH_HOST" "docker exec $CONTAINER_NAME /bin/bash -c \"pg_isready > /dev/null; echo $?;\"")
	while ! $return_code; do
		echo "Retrying connection to postgres db..."
		sleep .2
	done 
}

remote_docker_restart() {
	ssh -T "$SSH_HOST" "docker restart $CONTAINER_NAME"
}

remote_psql_command() {
	cmd="$1"
	db="$2"

	psql "$DB_CONN/$db" -c "$cmd"
}

set_wal_level_minimal() {
	# set it back afterwards to this
	remote_psql_command "SHOW wal_level;" "postgres"

	# set wal level to minimal
	remote_psql_command "ALTER SYSTEM SET wal_level = 'minimal';" "postgres"
	remote_psql_command "SELECT pg_reload_conf();" "postgres"

	remote_docker_restart
	wait_postgres
}

set_wal_level_replica() {
	# set wal level to old value
	remote_psql_command "ALTER SYSTEM SET wal_level = 'replica';" "postgres"
	remote_psql_command "SELECT pg_reload_conf();" "postgres"
	remote_docker_restart
	wait_postgres
}

run_sql() {
	sql_file="$1"
	sql_cmds=$(cat "$sql_file")

	remote_psql_command "$sql_cmds" "domains"
}