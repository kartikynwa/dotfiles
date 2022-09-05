#!/usr/bin/env sh

echo "RUNNING IN DRY RUN MODE ;)"
xbps-install -S $( cat packages.txt | sed -e '/^#[^!].*/d' -e 's/\(.*[^!]\)#.*[^}]/\1/' | tr '\n' ' ' )
