#!/usr/bin/env sh

while true; do
  wg0=$(sudo wg show wg0 2> /dev/null)
  if [ $? = 0 ]; then
    echo "status|string|wg0 up"
  else
    echo "status|string|wg0 down"
  fi
  echo ""
  sleep 5
done
