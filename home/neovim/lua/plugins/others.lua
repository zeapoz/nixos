return {
  { "direnv/direnv.vim" },

  {
    "elkowar/yuck.vim",
    ft = { "yuck" },
  },

  {
    "willothy/wezterm.nvim",
    config = true,
    init = function()
      require("wezterm").set_user_var("set_padding", 0)
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    config = true,
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<A-Left>", function() require("smart-splits").move_cursor_left() end },
      { "<A-Down>", function() require("smart-splits").move_cursor_down() end },
      { "<A-Up>", function() require("smart-splits").move_cursor_up() end },
      { "<A-Right>", function() require("smart-splits").move_cursor_right() end },
      { "<C-Left>", function() require("smart-splits").resize_left() end },
      { "<C-Down>", function() require("smart-splits").resize_down() end },
      { "<C-Up>", function() require("smart-splits").resize_up() end },
      { "<C-Right>", function() require("smart-splits").resize_right() end },
    },
  },
}
