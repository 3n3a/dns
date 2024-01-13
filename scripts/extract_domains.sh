#!/bin/bash
#
# extract domains from tld dns zones file
# also deduplicate them
#

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

tld="$1"
awk '$4=="ns" {print $1}' "$tld.txt" | sort -u > "$SCRIPT_DIR/../$tld-domains.txt"