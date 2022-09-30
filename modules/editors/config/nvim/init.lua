-- General settings.
require('settings')
require('keybindings')

-- Plugin configurations.
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('nvim-tree').setup()
require('gitsigns').setup()
require('lualine').setup()
