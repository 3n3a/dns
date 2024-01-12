#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
dig -k "$SCRIPT_DIR/../_resources/li_zonedata.key" @zonedata.switch.ch +noall +answer +noidnout +onesoa AXFR li. > "$SCRIPT_DIR/../zones/li.txt"
