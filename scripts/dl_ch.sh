#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
dig -k "$SCRIPT_DIR/../_resources/ch_zonedata.key" @zonedata.switch.ch +noall +answer +noidnout +onesoa AXFR ch. > "$SCRIPT_DIR/../zones/ch.txt"
