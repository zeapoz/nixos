return {
  { "LazyVim/LazyVim", opts = {
    colorscheme = "kanagawa",
  } },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    -- https://github.com/rebelot/kanagawa.nvim/issues/243
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "kanagawa",
        callback = function()
          vim.api.nvim_set_hl(0, "StatusLine", { link = "lualine_c_normal" })
        end,
      })
    end,
    opts = {
      transparent = not vim.g.neovide,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function(colors)
        local theme = colors.theme
        return {
          CursorLineNr = { bg = theme.ui.bg_p2 },
          CursorLineSign = { bg = theme.ui.bg_p2 },
          FloatBorder = { bg = theme.ui.bg_m1, fg = theme.ui.bg_m1 },
          TreesitterContext = { link = "Normal" },

          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = 0 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          NeoTreeTitleBar = { fg = theme.ui.special, bold = true, bg = theme.ui.bg_m1 },
          NeoTreeNormal = { bg = theme.ui.bg_m1 },
          NeoTreeNormalNC = { link = "NeoTreeNormal" },

          -- Treesitter capture groups.
          ["@module"] = { fg = theme.syn.constant },
          ["@function.macro"] = { fg = theme.syn.preproc },
          ["@lsp.type.macro"] = { fg = theme.syn.prepoc },
          ["@lsp.type.decorator"] = { fg = theme.syn.prepoc },
          ["@operator.try"] = { fg = theme.syn.special3 },
          ["@keyword.await"] = { fg = theme.syn.special3 },
          ["@keyword.import"] = { fg = theme.syn.keyword },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      require("kanagawa").load()
    end,
  },
}
