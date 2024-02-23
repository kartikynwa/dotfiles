#!/usr/bin/env python3

import subprocess
import json
import sys


NOTIFY_ID = "92835743"


def manipulate_device(device_id: int, enable: bool):
    profile_key = ("on" if enable else "off") + "_profile"
    index = devices[device_id][profile_key]["index"]
    subprocess.run(["wpctl", "set-profile", str(device_id), str(index)])


def notify(body: str):
    subprocess.run(
        ["notify-send", "-r", NOTIFY_ID, "Pipewire Audio Device Switcher", body]
    )


try:
    out = subprocess.run("pw-dump", capture_output=True)
    dump = json.loads(str(out.stdout.decode()))

    devices = {}
    for node in dump:
        if (
            node["type"] == "PipeWire:Interface:Device"
            and node["info"]["props"].get("media.class", "") == "Audio/Device"
        ):
            profiles = node["info"]["params"]["EnumProfile"]
            off_profile = min(profiles, key=lambda p: p["priority"])
            on_profile = max(profiles, key=lambda p: p["priority"])
            node["off_profile"] = off_profile
            node["on_profile"] = on_profile
            devices[node["id"]] = node

    rofi_input = "\n".join(
        [
            str(id) + ":" + device["info"]["props"]["device.description"]
            for id, device in devices.items()
        ]
    )
    if not rofi_input:
        notify("No available devices")
        sys.exit(0)

    rofi_output = subprocess.Popen(
        ["rofi", "-dmenu", "-p", "Select audio device"],
        stdout=subprocess.PIPE,
        stdin=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    ).communicate(rofi_input)[0]

    if not rofi_output:
        sys.exit(0)

    selected_device_id = int(rofi_output.split(":")[0])

    manipulate_device(selected_device_id, True)
    for device_id in devices:
        if device_id != selected_device_id:
            manipulate_device(device_id, False)

    notify(
        devices[selected_device_id]["info"]["props"]["device.description"] + " selected"
    )

except Exception as e:
    notify(f"Error: {e}")
