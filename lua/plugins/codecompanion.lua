local prefix = '<leader>A'
return {
  'olimorris/codecompanion.nvim',
  lazy = false,
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
    'CodeCompanionCmd',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},

  config = function(_, opts)
    require('codecompanion').setup(opts)

    -- Mapeos en normal y visual mode
    local map = vim.keymap.set
    local icon = '󱙺 '

    map('n', prefix, '', { desc = icon .. 'CodeCompanion' })
    map('v', prefix, '', { desc = icon .. 'CodeCompanion' })
    map('n', prefix .. 'c', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
    map('v', prefix .. 'c', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
    map('n', prefix .. 'p', '<cmd>CodeCompanionActions<cr>', { desc = 'Open action palette' })
    map('v', prefix .. 'p', '<cmd>CodeCompanionActions<cr>', { desc = 'Open action palette' })
    map('n', prefix .. 'q', '<cmd>CodeCompanion<cr>', { desc = 'Open inline assistant' })
    map('v', prefix .. 'q', '<cmd>CodeCompanion<cr>', { desc = 'Open inline assistant' })
    map('v', prefix .. 'a', '<cmd>CodeCompanionChat Add<cr>', { desc = 'Add selection to chat' })
  end,
}
