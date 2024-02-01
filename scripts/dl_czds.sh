#!/bin/bash
#
# dl cdzds
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

(cd "$SCRIPT_DIR/../czds" && python3 download.py)
