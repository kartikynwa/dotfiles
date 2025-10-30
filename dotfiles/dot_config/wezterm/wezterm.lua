local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.color_scheme = 'Tomorrow Night (Gogh)'
config.use_fancy_tab_bar = false

config.keys = {
  { key = 't', mods = 'SHIFT|ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateLastTab },
  { key = 'h', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(-1) },
  { key = 'l', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(1) },
  { key = '|', mods = 'SHIFT|ALT', action = act.SplitHorizontal },
  { key = '_', mods = 'SHIFT|ALT', action = act.SplitVertical },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
}

-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

return config
