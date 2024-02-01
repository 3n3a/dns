#!/bin/bash
#
# unpack all zonefiles

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
zonefiles_dir="$SCRIPT_DIR/../zones/zonefiles"

"$SCRIPT_DIR/unpack_all_gzip.sh" "$zonefiles_dir"