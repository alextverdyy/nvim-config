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


  end,
}
