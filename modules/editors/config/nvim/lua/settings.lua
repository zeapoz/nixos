local opt = vim.opt

-- Theme.
opt.termguicolors = true
vim.cmd [[ colorscheme gruvbox-material ]]

-- General settings.
opt.number = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.hlsearch = false
opt.mouse = 'a'

-- Tab settings.
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.expandtab = true
opt.smartindent = true

-- Use system clipboard.
opt.clipboard = 'unnamed,unnamedplus'
