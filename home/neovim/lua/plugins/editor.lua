local Util = require("lazyvim.util")

return {

  {
    "folke/flash.nvim",
    opts = {
      label = { rainbow = { enabled = true } },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({
            action = "show",
            toggle = true,
            reveal = true,
            position = "left",
            dir = Util.root(),
          })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({
            action = "show",
            toggle = true,
            position = "left",
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal = true, position = "float", dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal = true, position = "float", dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
  },
}
