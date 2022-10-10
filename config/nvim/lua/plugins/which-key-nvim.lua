local wk = require('which-key')

wk.register({
  b = {
    name = 'Buffers',
    d = { ':bp<bar>bd#<CR>', 'Delete Buffer' },
    k = { ':bd<CR>', 'Kill Buffer' },
  },
  c = {
    name = 'LSP',
    a = 'Code Actions',
    f = 'Format Code',
  },
  d = {
    name = 'Type Definition',
  },
  f = {
    name = 'Telescope',
    f = { ':Telescope find_files<CR>', 'Find File' },
    w = { ':Telescope live_grep<CR>', 'Find Word' },
    b = { ':Telescope buffers<CR>', 'Open Buffers' },
    r = { ':Telescope oldfiles<CR>', 'Open Recent File' },
    c = { ':Telescope colorscheme<CR>', 'Set Colorscheme' },
    d = { ':Telescope diagnostics<CR>', 'Open Diagnostics' },
  },
  o = {
    name = 'Open',
    p = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
    f = { ':NvimTreeFindFile<CR>', 'Find File NvimTree' },
    t = { ':ToggleTerm<CR>', 'Toggle Terminal' },
    h = { ':Dashboard<CR>', 'Dashboard' },
    e = { ':DashboardNewFile<CR>', 'Empty Buffer' },
  },
  r = {
    name = 'Rename',
    n = 'LSP Rename',
  },
  w = {
    name = 'Workspaces',
    a = { 'Add Workspace Folder' },
    l = { 'List Workspace Folders' },
    r = { 'Remove Workspace Folder' },
  },
}, { prefix = '<space>' })
