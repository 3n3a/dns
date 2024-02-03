#!/bin/bash
#
# main script for
# - getting data
# - processing data
# - loading into postgres
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LOG_FILE="$SCRIPT_DIR/../zones/logs/$(date +"%Y%m%d_%H%M%S")_domains_etl.log"

# env read
source "$SCRIPT_DIR/.env"

# Redirect stdout and stderr to the logfile
exec > >(tee -a "$LOG_FILE") 2>&1

# imports
source "$SCRIPT_DIR/lib_remote.sh"

info() {
	echo "$(date -Is): $1"
}

get_data() {
	info "get_data started"

	# ch, li
	"$SCRIPT_DIR/dl_ch.sh"
	"$SCRIPT_DIR/dl_li.sh"

	# all other czds supported
	"$SCRIPT_DIR/dl_czds.sh"

	info "get_data ended"
}

process_data() {
	set -x
	info "process_data started"

	info "cleaning up urls directory"
	rm -f $SCRIPT_DIR/../zones/urls/*
	rm -f $SCRIPT_DIR/../zones/export/all-domains.txt

	info "unpacking all gzipped zonefiles"
	"$SCRIPT_DIR/unpack_all_zonefiles.sh"

	info "extracting all the urls from the zonefiles"
	"$SCRIPT_DIR/extract_all_urls.sh"

	info "combining all the extracted urls into a single file"
	"$SCRIPT_DIR/combine_all_urls.sh"

	sleep .5

	info "process_data ended"
}

load_data() {
	info "load_data started"

	info "upload file to db-server"
	copy_to_server "$SCRIPT_DIR/../zones/export/all-domains.txt"

	info "create tables if not exists"
	run_sql "$SCRIPT_DIR/../sql/create_domains_table.sql"

	info "load into temp table"
	#set_wal_level_minimal
	run_sql "$SCRIPT_DIR/../sql/create_domains_temp_table.sql"
	#set_wal_level_replica

	info "upsert from temp to final table"
	run_sql "$SCRIPT_DIR/../sql/upsert_temp_data.sql"

	info "clean temp table"
	run_sql "$SCRIPT_DIR/../sql/clean_temp_data.sql"

	info "create indexes if not exists"
	run_sql "$SCRIPT_DIR/../sql/create_domains_index.sql"

	info "process_data ended"
}

main() {
	info "started domains etl"

	time get_data
	time process_data
	time load_data

	info "finished domains etl"
}

time main