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

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Undo History" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
    keys = {
      { "<leader>.", Util.pick("files"), desc = "Find Files (root directory)" },
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fl",
        function()
          local files = {} ---@type table<string, string>
          for _, plugin in pairs(require("lazy.core.config").plugins) do
            repeat
              if plugin._.module then
                local info = vim.loader.find(plugin._.module)[1]
                if info then
                  files[info.modpath] = info.modpath
                end
              end
              plugin = plugin._.super
            until not plugin
          end
          require("telescope.builtin").live_grep({ search_dirs = vim.tbl_values(files) })
        end,
        desc = "Find Lazy Plugin Spec",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top" },
          vertical = {
            mirror = true,
            prompt_position = "top",
          },
          flex = {
            flip_columns = 120,
          },
        },
        sorting_strategy = "ascending",
        mappings = {
          i = { ["<Esc>"] = require("telescope.actions").close },
        },
        borderchars = { "", "", "", "", "", "", "", "" },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "-g",
            "!.git",
          },
        },
      },
    },
  },
}
