#!/usr/bin/env sh

torrent_client="transmission-da"

while true; do
  if pgrep -x "${torrent_client}" > /dev/null
  then
    echo "status|string|arr"
  else
    echo "status|string|no arr"
  fi
  echo ""

  sleep 5
done
