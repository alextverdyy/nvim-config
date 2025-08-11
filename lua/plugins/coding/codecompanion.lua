-- CodeCompanion AI assistant
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

    local prefix = '<leader>A'
    local map = vim.keymap.set
    local icon = '󱙺 '

    map('n', prefix, '', { desc = icon .. 'CodeCompanion' })
    map('v', prefix, '', { desc = icon .. 'CodeCompanion' })
    map('n', prefix .. 'c', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
    map('v', prefix .. 'c', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
    map('n', prefix .. 'a', '<cmd>CodeCompanionActions<cr>', { desc = 'Actions' })
    map('v', prefix .. 'a', '<cmd>CodeCompanionActions<cr>', { desc = 'Actions' })
  end,
}
