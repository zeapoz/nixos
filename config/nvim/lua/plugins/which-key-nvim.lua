local wk = require('which-key')

wk.register({
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
    e = { ':DashboardNewFile<CR>', 'Empty buffer' },
  },
}, { prefix = '<space>' })
