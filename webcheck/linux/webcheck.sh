#!/bin/bash

URL="$1"
shift

tmp_file=$(mktemp)

function cleanup {
  echo "Cleanup on exit: $tmp_file"
  rm "$tmp_file"
}

trap cleanup EXIT

echo "Downloading: '$URL'"
wget --quiet -O "$tmp_file" "$URL" || { echo 'Download failed' ; exit 1; }

for token in "$@"
do
  echo -n "Checking: '$token' - "
  grep "$token" "$tmp_file" || { echo 'MISSING'; exit 2; }
done
