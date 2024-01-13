#!/bin/bash
#
# unpack all .gz files in current and subdirs
#

echo "Starting unpacking of .gz files recursively, starting in current dir..."
find . -type f -name "*.gz" -exec gzip -d {} +

