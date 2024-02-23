#!/usr/bin/env sh

selected_device=$(pw-dump |
  jq -r '.[] | select(
    .type == "PipeWire:Interface:Node" and
    .info.props."media.class" == "Audio/Sink"
  ) |
  {id, type, name: (
    .info.name //
    (.info.props | (
      ."application.name" //
      ."node.description")
    ) //
    .type)
  } |
  "\(.id):\(.name | gsub(":"; "\\:"))"' |
  rofi -dmenu -p "Select audio sink")

if [ -n "$selected_device" ]; then
  wpctl set-default $(echo "$selected_device" | cut -d: -f1)
  echo "[pipewire] Default audio sink changed to: $selected_device"
else
  >&2 echo "No device selected"
fi
