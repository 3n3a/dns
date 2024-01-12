#!/bin/bash
#
# calculate how many tlds support rdap
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/lib_iana.sh"

rdap=$(get_tlds_rdap_count)
normal=$(get_tlds_registered_count)

echo "Calculation of RDAP Support in TLDs"
echo "==================================="

echo ""
echo "TLDs supporting RDAP: $rdap"
echo "TLDs in general: $normal"
echo ""

echo "Percentage of TLDs which Support RDAP: "
python3 -c "print(str(round($rdap / $normal * 100, 2)) + ' %')"
