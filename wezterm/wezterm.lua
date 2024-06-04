local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font {
    family = 'FiraCode Nerd Font',
    weight = 450,
}
config.color_scheme = "Ef-Trio-Light"

return config
