#!/usr/bin/env sh

set -eu

TIMEFILE=/var/run/update-hosts.timefile

if [ "$#" -ge 1 ] && [ "$1" = "--timefile" ]; then
	echo $TIMEFILE
	exit
fi

hostsfile_url="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" 
distractions="
# [Distraction]
0.0.0.0 reddit.com     
0.0.0.0 i.reddit.com
0.0.0.0 v.reddit.com  
0.0.0.0 www.reddit.com
0.0.0.0 m.reddit.com
0.0.0.0 api.reddit.com
0.0.0.0 old.reddit.com
0.0.0.0 imgur.com
0.0.0.0 i.imgur.com
"

temp_hostsfile=$( mktemp )
trap "rm -f \"${temp_hostsfile}\"" INT

curl --retry 5 --retry-delay 1800 -sf "$hostsfile_url" | grep "^#\|^0.0.0.0 \|^$" > "$temp_hostsfile"
echo "$distractions" >> "$temp_hostsfile"
sed -i "15 a 0.0.0.0 localhost" "$temp_hostsfile"
cat "$temp_hostsfile" > /etc/hosts
rm -f "$temp_hostsfile"

logger "/etc/hosts updated sucessfully."
echo "hosts file updated at: $(date)" >> /root/update-hosts.log
touch $TIMEFILE
