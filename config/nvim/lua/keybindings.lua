local map = vim.keymap.set

-- Better up/down movement.
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move text up and down.
map('n', '<A-j>', ":m .+1<CR>==")
map('n', '<A-k>', ":m .-2<CR>==")
map('i', '<A-j>', "<Esc>:m .+1<CR>==gi")
map('i', '<A-k>', "<Esc>:m .-2<CR>==gi")
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Clear search with <Esc>
map({ 'i', 'n' }, "<Esc>", "<Cmd>noh<CR><Esc>")

-- Stay in visual mode when indenting.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Nvim-cokeline.
map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
map('n', '<space>p', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<space>n', '<Plug>(cokeline-switch-next)', { silent = true })

for i = 1, 9 do
  map('n', ('<F%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
  map('n', ('<space>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end
