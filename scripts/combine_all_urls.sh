#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

folder="$SCRIPT_DIR/../zones/urls"
inf='*-domains.txt'
expf="$SCRIPT_DIR/../zones/export/all-domains.txt"
find $folder -maxdepth 1 -type f -iname $inf -print0 |
  sort -z |
  xargs -0 cat -- >> "$expf"
