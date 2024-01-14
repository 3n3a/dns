#!/bin/bash
#
# unpack all .gz files in current and subdirs
#


folder="$1"
pattern='*.gz'

echo "Starting unpacking of .gz files recursively, starting in current dir..."
find $folder -type f -iname $pattern -exec gzip -d {} +

