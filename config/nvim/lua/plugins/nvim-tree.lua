require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = "h", action = "dir_up" },
        { key = "l", action = "cd" },
      },
    },
  },
  -- Project.nvim integration.
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
}
