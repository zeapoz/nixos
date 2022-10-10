-- General settings.
require('settings')
require('keybindings')

-- Plugin configurations.
require('plugins/dashboard-nvim')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('plugins/which-key-nvim')
require('plugins/toggleterm')
require('plugins/bufferline')
require('plugins/nvim-cmp')
require('plugins/lualine')
require('nvim-tree').setup()
require('gitsigns').setup()
require('Comment').setup()
