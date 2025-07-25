return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>oA", "<cmd>CodeCompanionActions<cr>", desc = "Open AI Actions", mode = { "n", "v" } },
      {
        "<leader>oa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Open AI Chat",
        mode = { "n", "v" },
      },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "Add selected text to Chat", mode = { "v" } },
    },
    opts = {
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:secret-tool lookup url https://generativelanguage.googleapis.com",
            },
          })
        end,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
