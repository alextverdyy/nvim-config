return {
  -- Calls `require('slimline').setup({})`
  'sschleemilch/slimline.nvim',
  opts = {
    style = 'fg',
    spaces = {
      components = '',
      left = '',
      right = '',
    },
    configs = {
      mode = {
        format = {
          ['n'] = { short = 'NOR' },
          ['v'] = { short = 'VIS' },
          ['V'] = { short = 'V-L' },
          ['\22'] = { short = 'V-B' },
          ['s'] = { short = 'SEL' },
          ['S'] = { short = 'S-L' },
          ['\19'] = { short = 'S-B' },
          ['i'] = { short = 'INS' },
          ['R'] = { short = 'REP' },
          ['c'] = { short = 'CMD' },
          ['r'] = { short = 'PRO' },
          ['!'] = { short = 'SHE' },
          ['t'] = { short = 'TER' },
          ['U'] = { short = 'UNK' },
        },
      },
      git = {
        trunc_width = 120,
        icons = {
          branch = '',
          added = '+',
          modified = '~',
          removed = '-',
        },
      },
      path = {
        trunc_width = 60,
        directory = false,
        truncate = false,
        icons = {
          folder = ' ',
          modified = '',
          read_only = '',
        },
      },
    },
  },
}
