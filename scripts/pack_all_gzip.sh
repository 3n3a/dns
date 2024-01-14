#!/bin/bash
#
# gzip all files
#
# they will still be searchable with the zgrep utility
#

folder="$1"
pattern='*.txt'

find $folder -type f -iname $pattern -exec bash -c 'gzip -c "$1" > "${1%.txt}.gz"' _ {} \;
