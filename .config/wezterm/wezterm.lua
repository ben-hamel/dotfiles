local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBar"
config.font = wezterm.font("JetBrainsMono Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12.5
config.color_scheme = 'Aura (Gogh)'
config.skip_close_confirmation_for_processes_named = {}
config.window_close_confirmation = 'AlwaysPrompt'
config.debug_key_events = true


config.keys = {
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
    {
      key = 'k',
      mods = "CMD",
      action = act.Multiple {
        act.ClearScrollback 'ScrollbackAndViewport',
        act.SendKey { key = 'L', mods = 'CTRL' },
      },
    },
}


return config
