#!/usr/bin/env python3

from mpd import MPDClient
import os
import psutil

client_ip = "127.0.0.1"
client_port = 6600

if __name__ == "__main__":
    # Connect to mpd
    client = MPDClient()
    client.timeout = 10
    client.idletimeout = 10
    try:
        client.connect(client_ip, client_port)
    except:
        print("mpd down")
        exit(1)

    # Get status
    status = client.status()
    song = client.currentsong()

    # Get play state
    if status["state"] == "stop":
        print("mpd stopped")
        exit(0)
    elif status["state"] == "play":
        state_string = ">"
    else:
        state_string = "|"

    # Get volume percent
    vol_string = "<" + status["volume"] + "%>"

    # Get song name
    if "title" in song:
        song_string = '"' + song["title"] + '"'
        if "artist" in song:
            song_string += " by " + song["artist"]
        if len(song_string) > 40:
            song_string = song_string[:37] + "..."
    else:
        song_string = os.path.basename(song["file"])

    output = " ".join([state_string, song_string, vol_string])

    if "ashuffle" in (p.name() for p in psutil.process_iter()):
        output = " ".join([output, "<ash>"])

    print(output)

    # Close connection
    client.close()
    client.disconnect()
