require('dashboard').setup {
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Projects',
        group = 'Number',
        action = 'Telescope projects',
        key = 'p',
      },
    },
    packages = { enable = false },
  },
}
