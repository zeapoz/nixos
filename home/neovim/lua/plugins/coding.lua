return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  {
    "echasnovski/mini.pairs",
    opts = { mappings = { [" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" } } },
  },

  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- TODO: If not treesitter available don't bind.
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
