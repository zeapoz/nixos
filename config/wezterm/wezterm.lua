-- Add config folder to watchlist for config reloads.
local wezterm = require("wezterm")
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

local function set_padding(window, value)
  local overrides = window:get_config_overrides() or {}
  local new_padding = {
    left = value,
    right = value,
    top = value,
    bottom = value,
  }
  if overrides.window_padding and new_padding.left == overrides.window_padding.left then
    -- padding is same, avoid triggering further changes
    return
  end
  overrides.window_padding = new_padding
  window:set_config_overrides(overrides)
end

local default_opacity = 0.7
local function toggle_opacity(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 1
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end

wezterm.on("toggle-opacity", function(window)
  toggle_opacity(window)
end)

wezterm.on("user-var-changed", function(window, _, name, value)
  if name == "set_padding" then
    set_padding(window, value)
  elseif name == "toggle_opacity" then
    toggle_opacity(window)
  end
end)

return {
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Font Awesome 6 Free Solid",
  }),
  font_size = 12.0,
  force_reverse_video_cursor = true,
  colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
  window_background_opacity = default_opacity,
  hide_tab_bar_if_only_one_tab = true,
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },
  keys = {
    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "O", mods = "CTRL", action = wezterm.action.EmitEvent("toggle-opacity") },
  },
  -- FIXME: Temporary fix since wayland support is currently broken.
  enable_wayland = false,
}
