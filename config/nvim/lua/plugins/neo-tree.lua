require('neo-tree').setup {
  popup_border_style = "rounded",
  window = {
    mappings = {
      ['o'] = 'open',
      ['l'] = 'set_root',
      ['h'] = 'navigate_up',
    },
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
  },
}
