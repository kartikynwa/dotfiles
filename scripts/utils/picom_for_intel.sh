#!/usr/bin/env sh

if glxinfo | grep -q Intel; then
  sv up "$(chezmoi source-dir)/i3_services/picom"
fi
