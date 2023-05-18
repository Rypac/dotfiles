local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Gruvbox dark, pale (base16)"
config.front_end = "WebGpu"
config.hide_tab_bar_if_only_one_tab = true
config.show_update_window = true
config.window_close_confirmation = "NeverPrompt"
config.quit_when_all_windows_are_closed = false

return config
