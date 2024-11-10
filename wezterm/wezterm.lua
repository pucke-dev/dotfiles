local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.set_environment_variables = {
  -- This changes the default prompt for cmd.exe to report the
  -- current directory using OSC 7, show the current time and
  -- the current directory colored in the prompt.
  XDG_CONFIG_HOME="/Users/philippucke/.config"
}

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "One Dark (Gogh)"
config.default_prog = { "/opt/homebrew/bin/nu" }
config.window_background_opacity = 0.80



return config
