return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    keys[#keys + 1] =
      { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
    if require("lazyvim.util").has("inc-rename.nvim") then
      keys[#keys + 1] = {
        "<leader>r",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
        has = "rename",
      }
    else
      keys[#keys + 1] = { "<leader>r", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
  end,
}
