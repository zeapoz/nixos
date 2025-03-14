return {
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "stevearc/resession.nvim",
    },
    opts = function()
      return {
        show_if_buffers_are_at_least = 2,

        default_hl = {
          fg = function(buffer)
            if buffer.diagnostics.errors >= 1 then
              return "DiagnosticError"
            elseif buffer.diagnostics.warnings >= 1 then
              return "DiagnosticWarn"
            end
            return "Normal"
          end,
          bg = "Normal",
        },

        sidebar = {
          filetype = { "neo-tree" },
          components = {
            {
              text = " " .. "Neo-tree Filesystem",
              fg = "FloatTitle",
              bg = "NeoTreeNormal",
              bold = true,
            },
          },
        },

        fill_hl = "Normal",

        components = {
          {
            text = function(buffer)
              return " " .. buffer.devicon.icon
            end,
            fg = function(buffer)
              if buffer.diagnostics.errors >= 1 then
                return "DiagnosticError"
              elseif buffer.diagnostics.warnings >= 1 then
                return "DiagnosticWarn"
              end
              return buffer.devicon.color
            end,
          },
          {
            text = function(buffer)
              return buffer.unique_prefix
            end,
            fg = "Comment",
            italic = true,
          },
          {
            text = function(buffer)
              return buffer.filename
            end,
            underline = function(buffer)
              return buffer.is_hovered
            end,
            bold = function(buffer)
              return buffer.is_focused
            end,
          },
          {
            text = " ",
          },
          {
            text = function(buffer)
              return buffer.is_modified and "●" or ""
            end,
            on_click = function(_, _, _, _, buffer)
              buffer:delete()
            end,
          },
          {
            text = " ",
          },
        },
      }
    end,
  },
}
