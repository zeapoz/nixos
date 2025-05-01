-- Add config folder to watchlist for config reloads.
local wezterm = require("wezterm")
local config = wezterm.config_builder()
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

local default_opacity = 0.5
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

local function is_vim(pane)
  local process_info = pane:get_foreground_process_info()
  local process_name = process_info and process_info.name
  return process_name == "nvim" or process_name == "vim"
end

local last_toggle_pane = nil
local vim_pane = nil
local options = {
  enable_wayland = true,
  font = wezterm.font_with_fallback({
    "Maple Mono NF",
    "Font Awesome 6 Free Solid",
  }),
  font_size = 9.0,
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
  text_background_opacity = default_opacity,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },
  keys = {
    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "O", mods = "ALT", action = wezterm.action.EmitEvent("toggle-opacity") },
    { key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "S", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "V", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "C", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    {
      key = "/",
      mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
        local tab = window:active_tab()
        if is_vim(pane) then
          vim_pane = pane
          if last_toggle_pane == nil or #tab:panes() == 1 then
            last_toggle_pane = pane:split({ direction = "Right", size = 0.4 })
          else
            local active_pane = tab:panes_with_info()[vim_pane:pane_id() + 1]
            if active_pane.is_zoomed then
              tab:set_zoomed(false)
              last_toggle_pane:activate()
            else
              tab:set_zoomed(true)
            end
          end
        else
          if vim_pane ~= nil then
            last_toggle_pane = pane
            vim_pane:activate()
            tab:set_zoomed(true)
          end
        end
      end),
    },
  },
}

for k, v in pairs(options) do
  config[k] = v
end

local list = wezterm.plugin.list()
wezterm.log_error(list)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
  direction_keys = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
  modifiers = {
    move = "ALT",
    resize = "CTRL",
  },
})

return config
