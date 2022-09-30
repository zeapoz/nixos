local home = os.getenv('HOME')
local db = require('dashboard')

db.custom_header = {
  '',
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '',
  'Hyperextensible Vim-based text editor',
  '',
}

db.custom_center = {
  {
    icon = '  ',
    desc = 'Recently opened files                ',
    shortcut = 'SPC f r',
  },
  {
    icon = '  ',
    desc = 'Find file                            ',
    shortcut = 'SPC f f',
  },
  {
    icon = '  ',
    desc = 'Find word                            ',
    shortcut = 'SPC f w',
  },
}
