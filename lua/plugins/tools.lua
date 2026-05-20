return {
  -- oil.nvim: primary file manager (<leader>e / <leader>E / -)
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { 'echasnovski/mini.icons' },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = { show_hidden = true },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-k>'] = false,
        ['<C-j>'] = false,
      },
    },
    keys = {
      { '<leader>e', '<cmd>Oil<cr>',                                             desc = 'Open Oil (current dir)' },
      { '<leader>E', function() require('oil').open(vim.loop.cwd()) end,         desc = 'Open Oil (cwd)' },
      { '-',         '<cmd>Oil<cr>',                                             desc = 'Open Oil (parent dir)' },
    },
  },
  -- obsidian.nvim: Obsidian vault integration
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      workspaces = {
        { name = 'personal', path = '~/vaults' },
      },
      completion = { nvim_cmp = false, min_chars = 2 },
      ui = { enable = false },
    },
  },
  -- Codeium / Windsurf AI completion (standalone vim plugin, no nvim-cmp needed)
  {
    'Exafunction/codeium.vim',
    event = 'InsertEnter',
    config = function()
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end,
        { expr = true, silent = true, desc = 'Codeium: Accept' })
      vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true, desc = 'Codeium: Next' })
      vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true, desc = 'Codeium: Prev' })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end,
        { expr = true, silent = true, desc = 'Codeium: Clear' })
    end,
  },
  -- CodeCompanion AI assistant
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat', 'CodeCompanionCmd' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
