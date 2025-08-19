return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  config = function()
    local homeVaultPath = vim.fn.expand '$HOME/vaults/work'
    ---@module 'obsidian'
    ---@type obsidian.config
    local opts = {
      workspaces = {
        {
          name = 'work',
          path = homeVaultPath,
        },
      },
    }
    require('obsidian').setup(opts)
  end,
}
