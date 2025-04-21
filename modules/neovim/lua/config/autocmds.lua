local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Reset wezterm values.
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  group = augroup("reset_wezterm_padding"),
  callback = function()
    require("wezterm").set_user_var("set_padding", 20)
  end,
})
