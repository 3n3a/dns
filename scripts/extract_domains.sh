#!/bin/bash
#
# extract domains from tld dns zones file
# also deduplicate them
#

tld=$1
awk '$4=="ns" {print $1}' "$tld.txt" | sort -u > "$SCRIPT_DIR/../$tld-domains.txt"