local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.window_background_opacity = 0.78
config.macos_window_background_blur = 23

config.window_decorations = "RESIZE"
 config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_padding = {
  left = 18,
  right = 18,
  top = 16,
  bottom = 16,
}

config.background = {
  {
    source = { File = wezterm.config_dir .. "/naruto.png" },
    hsb = {
      brightness = 0.55,
      saturation = 0.75,
    },
  },
  {
    source = { Color = "#08261b" },
    width = "100%",
    height = "100%",
    opacity = 0.42,
  },
}



config.font_size = 14.5
config.line_height = 1.12

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

config.enable_scroll_bar = false
config.scrollback_lines = 10000

config.front_end = "WebGpu"
config.max_fps = 120

config.default_prog = { "/opt/homebrew/bin/zsh", "-l" }

config.window_frame = {
  font = wezterm.font("Maple Mono NF"),
  font_size = 13.0,
}

config.colors = {
  background = "#0b1f22",
  foreground = "#c6d3d4",

  cursor_bg = "#8ff0ff",
  cursor_fg = "#0b1f22",
  cursor_border = "#8ff0ff",

  selection_bg = "#23484d",
  selection_fg = "#ffffff",

  tab_bar = {
    background = "rgba(10, 25, 28, 0.45)",
    active_tab = {
      bg_color = "#143236",
      fg_color = "#8ff0ff",
    },
    inactive_tab = {
      bg_color = "#0b1f22",
      fg_color = "#6b8b91",
    },
  },
}

config.front_end = "WebGpu"

config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.75,
}



return config
