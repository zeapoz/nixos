local map = vim.keymap.set

-- Move text up and down.
map('n', '<A-j>', ":m .+1<CR>==")
map('n', '<A-k>', ":m .-2<CR>==")
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Stay in indent mode.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Bufferline.
map('n', 'gH', ':BufferLineCyclePrev<CR>')
map('n', 'gL', ':BufferLineCycleNext<CR>')
