#!/bin/bash
#
# calculate how many tlds support rdap
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/lib_iana.sh"

rdap=$(get_tlds_rdap_count)
normal=$(get_tlds_registered_count)

echo "Calculation of RDAP Support in TLDs: "
python3 -c "print(str(round($rdap / $normal * 100, 2)) + ' %')"
