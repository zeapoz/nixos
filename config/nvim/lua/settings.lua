local o = vim.o

-- Theme.
o.termguicolors = true
vim.cmd [[ colorscheme onedark ]]

-- General settings.
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
o.hlsearch = false
o.cmdheight = 0
o.mouse = 'a'
o.timeoutlen = 0

-- Tab settings.
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.expandtab = true
o.autoindent = true
o.smartindent = true

-- Gui settings.
o.guifont = 'FiraCode Nerd Font:h14'
vim.api.nvim_set_var('neovide_transparency', 0.9)

-- Use system clipboard.
o.clipboard = 'unnamed,unnamedplus'

-- Autocommands.
local autocmd = vim.api.nvim_create_autocmd

-- Per file type indentation.
autocmd('Filetype', {
  pattern = { 'nix', 'lua', 'json', 'yaml' },
  command = 'setlocal tabstop=2 shiftwidth=2',
})

-- Format on save.
vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.format() ]]
