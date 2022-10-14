local g = vim.go
local o = vim.o

-- Theme.
o.termguicolors = true
vim.cmd [[ colorscheme gruvbox-material ]]

-- General settings.
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
o.hlsearch = false
o.cmdheight = 0
o.mouse = 'a'

-- Tab settings.
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.expandtab = true
o.autoindent = true
o.smartindent = true

-- Gui settings.
o.guifont = 'FiraCode Nerd Font:h15'
vim.api.nvim_set_var('neovide_transparency', 0.9)

-- Use system clipboard.
o.clipboard = 'unnamed,unnamedplus'

-- Per file type indentation.
local autocmd = vim.api.nvim_create_autocmd

autocmd('Filetype', {
  pattern = { 'nix', 'lua', 'json', 'yaml' },
  command = 'setlocal tabstop=2 shiftwidth=2',
})
