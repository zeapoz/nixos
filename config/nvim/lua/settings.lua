local opt = vim.opt

-- Theme.
opt.termguicolors = true
vim.cmd [[ colorscheme gruvbox-material ]]

-- General settings.
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.hlsearch = false
opt.cmdheight = 0
opt.mouse = 'a'

-- Tab settings.
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Use system clipboard.
opt.clipboard = 'unnamed,unnamedplus'

-- Per file type indentation.
local autocmd = vim.api.nvim_create_autocmd

autocmd('Filetype', {
  pattern = { 'nix', 'lua', 'json', 'yaml' },
  command = 'setlocal tabstop=2 shiftwidth=2',
})
