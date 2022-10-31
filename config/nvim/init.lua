-- General settings.
require('settings')
require('keybindings')

-- Plugin configurations.
require('plugins/indent-blankline')
require('plugins/dashboard-nvim')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('plugins/which-key-nvim')
require('plugins/nvim-cokeline')
require('plugins/toggleterm')
require('plugins/telescope')
require('plugins/nvim-cmp')
require('plugins/neo-tree')
require('plugins/lualine')
require('nvim-surround').setup()
require('project_nvim').setup {
  show_hidden = true,
}
require('gitsigns').setup()
require('Comment').setup()
require('neogit').setup()
