local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better up/down movement.
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- Move text up and down.
map('n', '<A-j>', ":m .+1<CR>==", opts)
map('n', '<A-k>', ":m .-2<CR>==", opts)
map('i', '<A-j>', "<Esc>:m .+1<CR>==gi", opts)
map('i', '<A-k>', "<Esc>:m .-2<CR>==gi", opts)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Clear search with <Esc>
map({ 'i', 'n' }, "<Esc>", "<Cmd>noh<CR><Esc>", opts)

-- Stay in visual mode when indenting.
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Nvim-cokeline.
map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', opts)
map('n', '<Tab>', '<Plug>(cokeline-focus-next)', opts)
map('n', '<space>p', '<Plug>(cokeline-switch-prev)', opts)
map('n', '<space>n', '<Plug>(cokeline-switch-next)', opts)

for i = 1, 9 do
  map('n', ('<F%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), opts)
  map('n', ('<space>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), opts)
end
