local autosave_enabled = true
local timer = nil

local function save_if_needed()
  if autosave_enabled and vim.bo.modifiable and vim.bo.modified then
    -- Do not autosave if currently in Insert mode, meaning you're actively typing.
    if vim.fn.mode() == "i" then
      return
    end
    vim.cmd("silent! wall")
  end
end

-- Auto-save after 2 seconds idle
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function()
    if not autosave_enabled then
      return
    end

    if timer then
      timer:stop()
      timer:close()
    end

    timer = vim.loop.new_timer()
    -- Timer callback is wrapped with vim.schedule_wrap to run in the main loop.
    timer:start(1000, 0, vim.schedule_wrap(save_if_needed))
  end,
  nested = true,
})

-- Auto-save on focus lost or buffer leave
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  callback = save_if_needed,
})

-- Toggle autosave keymap
vim.keymap.set("n", "<leader>ue", function()
  autosave_enabled = not autosave_enabled
  vim.notify("Autosave " .. (autosave_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Autosave" })
