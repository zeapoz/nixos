return {
  { "direnv/direnv.vim" },

  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = true,
  },
}
