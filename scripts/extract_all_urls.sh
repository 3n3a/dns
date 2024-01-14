#!/bin/bash
#set -x

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
zonefiles_dir="$SCRIPT_DIR/../zones/zonefiles"
urls_dir="$SCRIPT_DIR/../zones/urls"

extract_domains() {
        tld="$1"
        inf="$zonefiles_dir/$tld.txt"
        ouf="$urls_dir/$tld-domains.txt"

        if [ -s "$ouf" ]; then
          echo "File for $tld exists and not empty."
        else
          awk 'tolower($4)=="ns" {print $1}' $inf | grep -E '^[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+\.$' | sort -u > "$ouf"
        fi
}

for file in $zonefiles_dir/*.txt; do
    echo "Processing $file"
    filename=$(basename "$file" .txt)
    extract_domains "$filename"
done
