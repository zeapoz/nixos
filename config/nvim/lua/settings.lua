local o = vim.o
local onedark = require('onedark')

-- Theme.
o.termguicolors = true
onedark.setup {
  transparent = true,
  ending_tildes = true,
  code_style = {
    comments = 'none',
  },
  lua_line = {
    transparent = true,
  },
}
onedark.load()

-- General settings.
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
o.hlsearch = false
o.cmdheight = 0
o.mouse = 'a'
o.timeoutlen = 0
o.scrolloff = 8

o.ignorecase = true
o.smartcase = true

-- Indent settings.
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.breakindent = true
o.showbreak = '󱞩 '

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

-- Highlight on yank
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

-- Format on save.
vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.format() ]]
