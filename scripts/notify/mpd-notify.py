#!/usr/bin/env python3

"""
Requires python3-mpd2 and notify-send.sh
"""

import subprocess
from mpd import MPDClient

n_body = []

client = MPDClient()
client.timeout = 1
try:
    client.connect("127.0.0.1", 6600)
except Exception:
    n_title = "mpd down"
else:
    song = client.currentsong()
    if song:
        vol = client.status()["volume"]
        if "title" in song:
            n_title = song["title"]
            if "track" in song:
                n_title = song["track"] + ". " + n_title
            if "artist" in song:
                n_body.append(f"by <b>{song['artist']}</b>")
            if "album" in song:
                n_body.append(f"from <b>{song['album']}</b>")
            n_body.append(f"at {vol}% volume")
        else:
            n_title = song["file"]
    else:
        n_title = "mpd stopped"
    client.close()
    client.disconnect()

notify_args = ["notify-send.sh", "-r", "13163", "-t", "4000", n_title]
if n_body:
    notify_args.append("\n".join(n_body))

subprocess.run(notify_args)
