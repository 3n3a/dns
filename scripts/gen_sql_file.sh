#!/bin/bash
#
# load exported domains
# into database (pg)
#

FILE_PATH="$1"
OUT="$2"

# Loop through each line in the text file
while IFS= read -r value; do
    echo "INSERT INTO domains (value) VALUES ('$value');" >> $OUT
done < "$FILE_PATH"
