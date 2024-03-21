#!/usr/bin/env python3

import subprocess
import json
import sys


NOTIFY_ID = "92835743"
DEVICES = {}


def manipulate_device(device_id: int, enable: bool):
    """Call `wpctl set-profile {device_id} {profile_index}`.

    profile_index will be the index of the profile with the maximum "priority" if `enabled`
    is True, otherwise it will be that of the profile witht the minimum "priority".
    """
    profile_key = ("on" if enable else "off") + "_profile"
    index = DEVICES[device_id][profile_key]["index"]
    subprocess.run(["wpctl", "set-profile", str(device_id), str(index)])


def notify(body: str):
    subprocess.run(
        ["notify-send", "-r", NOTIFY_ID, "Pipewire Audio Device Switcher", body]
    )


try:
    out = subprocess.run("pw-dump", capture_output=True)
    dump = json.loads(str(out.stdout.decode()))

    # Filter out `Audio/Devices` and store them in DEVICES
    for node in dump:
        if (
            node["type"] == "PipeWire:Interface:Device"
            and node["info"]["props"].get("media.class", "") == "Audio/Device"
        ):
            profiles = node["info"]["params"]["EnumProfile"]
            # Seems like the "Off" profile always have 0 priority. The highest priority profiles
            # seem to be sane defaults for the devices I have at hand.
            off_profile = min(profiles, key=lambda p: p["priority"])
            on_profile = max(profiles, key=lambda p: p["priority"])
            node["off_profile"] = off_profile
            node["on_profile"] = on_profile
            node["description"] = node["info"]["props"]["device.description"]
            DEVICES[node["id"]] = node

    rofi_input = "\n".join(
        [f"{id}:{device['description']}" for id, device in DEVICES.items()]
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

    # First, enable the device that was selected
    manipulate_device(selected_device_id, True)
    # Then, disable the devices that were not selected
    for device_id in DEVICES:
        if device_id != selected_device_id:
            manipulate_device(device_id, False)

    notify(f'"{DEVICES[selected_device_id]["description"]}" selected')

except Exception as e:
    notify(f"Error: {e}")
