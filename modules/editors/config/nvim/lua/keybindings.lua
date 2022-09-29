local map = vim.keymap.set

-- Move text up and down.
map('n', '<A-j>', ":m .+1<CR>==")
map('n', '<A-k>', ":m .-2<CR>==")
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Stay in indent mode.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Telescope.
map('n', '<space>ff', ':Telescope find_files<CR>')
map('n', '<space>fg', ':Telescope live_grep<CR>')
map('n', '<space>fb', ':Telescope buffers<CR>')
map('n', '<space>ht', ':Telescope colorscheme<CR>')

-- NvimTree.
map('n', '<space>b', ':NvimTreeToggle<CR>')
map('n', '<space>t', ':NvimTreeFocus<CR>')
