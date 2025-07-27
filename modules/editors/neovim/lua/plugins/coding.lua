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

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = function()
      local mc = require("multicursor-nvim")
      -- stylua: ignore
      return {
        { "<leader>m", function() mc.matchAddCursor(1) end, desc = "Add cursor at next match", mode = { "n", "x" } },
        { "<leader>M", function() mc.matchAddCursor(-1) end, desc = "Add cursor at previous match", mode = { "n", "x" } },
        { "<leader><down>", function() mc.lineAddCursor(1) end, desc = "Add cursor below", mode = { "n", "x" } },
        { "<leader><up>", function() mc.lineAddCursor(-1) end, desc = "Add cursor above", mode = { "n", "x" } },
        { "<leader>A", function() mc.matchAllAddCursors() end, desc = "Add cursor at all matches", mode = { "n", "x" } },
        { "<c-leftmouse>", function() mc.handleMouse() end, mode = { "n", "x" } },
        { "<c-leftdrag>", function() mc.handleMouseDrag() end, mode = { "n", "x" } },
        { "<c-leftrelease>", function() mc.handleMouseRelease() end, mode = { "n", "x" } },
      }
    end,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "n", mc.nextCursor)
        layerSet({ "n", "x" }, "N", mc.prevCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
