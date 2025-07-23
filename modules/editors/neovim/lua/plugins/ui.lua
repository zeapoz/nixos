return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = { "", "" },
        hover = {
          enabled = true,
          delay = 50,
          reveal = { "close" },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    },
  },

  -- { "folke/twilight.nvim" },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
