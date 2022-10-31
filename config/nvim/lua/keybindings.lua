local map = vim.keymap.set

-- Move text up and down.
map('n', '<A-j>', ":m .+1<CR>==")
map('n', '<A-k>', ":m .-2<CR>==")
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Stay in indent mode.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Nvim-cokeline.
map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
map('n', '<space>p', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<space>n', '<Plug>(cokeline-switch-next)', { silent = true })

for i = 1, 9 do
  map('n', ('<F%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
  map('n', ('<leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end
