return {
  {
    "mini.pairs",
    opts = { mappings = { [" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" } } },
  },

  {
    "blink.cmp",
    dependencies = { "hrsh7th/cmp-emoji", "blink.compat" },
    opts = {
      sources = {
        compat = { "emoji" },
      },
    },
  },

  -- TODO: If not treesitter available don't bind.
  {
    "treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
