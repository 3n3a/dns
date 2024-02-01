#!/bin/bash
#
# lib for dl switch.ch zones
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

dl_switch_zone() {
	zone="$1"
	echo "starting download for zonefile $zone"
	time dig -k "$SCRIPT_DIR/../_resources/${zone}_zonedata.key" @zonedata.switch.ch +noall +answer +noidnout +onesoa AXFR "$zone." > "$SCRIPT_DIR/../zones/zonefiles/$zone.txt"
	echo "finished download of $zone"
}
