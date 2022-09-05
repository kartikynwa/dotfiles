#!/usr/bin/env sh

# Script assigns random wallpaper when called.
# Wallpapers need to be placed in:
# $(chezmoi execute-template '{{ .chezmoi.workingTree }}')/wallpapers/

# feh needs to be installed

feh --randomize --bg-scale \
  $(chezmoi execute-template '{{ .chezmoi.workingTree }}')/wallpapers/*
