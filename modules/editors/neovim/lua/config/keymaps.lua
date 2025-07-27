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

-- Aliases for lsp keys.
map({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "Code Action" })
