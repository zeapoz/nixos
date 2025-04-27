local function map(mode, key, command, opts)
  vim.keymap.set(mode, key, command, opts)
end

-- Append a semicolon to this line.
map("n", "<leader>;", function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("norm A;")
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end)

-- Center view after scrolling.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center view after search.
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Only remove toggle terminal keybinding when not using GUI.
if not vim.g.neovide then
  vim.keymap.del("n", "<C-/>")
end

-- Toggle opaque background.
map("n", "<leader>uo", function()
  if vim.g.neovide then
    if vim.g.neovide_transparency < 1 then
      vim.g.neovide_transparency = 1
    else
      vim.g.neovide_transparency = 0.8
    end
  else
    -- Update wezterm opacity.
    require("wezterm").set_user_var("toggle_opacity")
  end
end, { desc = "Toggle background transparency" })
