#!/usr/bin/env sh

wg0=$( sudo wg show wg0 2> /dev/null )
if [ $? = 0 ]
then
  echo "wg0"
fi
