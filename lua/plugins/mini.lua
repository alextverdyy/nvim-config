return {
  -- Text objects (inner/around patterns)
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = { n_lines = 500 },
  },
  -- Surround actions (gz prefix)
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'gza',
        delete = 'gzd',
        find = 'gzf',
        find_left = 'gzF',
        highlight = 'gzh',
        replace = 'gzr',
        update_n_lines = 'gzn',
      },
    },
  },
  -- Auto-pairs (replaces nvim-autopairs)
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },
  -- Highlight patterns (hex colors, TODOs, etc.)
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPre',
    opts = function()
      local hi = require 'mini.hipatterns'
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  -- Icons (drop-in replacement for nvim-web-devicons)
  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
