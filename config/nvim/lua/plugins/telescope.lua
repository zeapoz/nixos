local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<esc>'] = require('telescope.actions').close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        'rg',
        '--files',
        '--hidden',
        '-g',
        '!.git',
      },
    },
    live_grep = {
      find_command = {
        'rg',
        '--files',
        '--hidden',
        '-g',
        '!.git',
      },
    },
  },
}

telescope.load_extension('projects')
