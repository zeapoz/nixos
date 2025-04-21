---@param plugins table
local function disable_plugins(plugins)
  local M = {}
  for _, name in ipairs(plugins) do
    table.insert(M, { name, enabled = false })
  end
  return M
end

return disable_plugins({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "akinsho/bufferline.nvim",
  "folke/tokyonight.nvim",
  "catppuccin",
})
