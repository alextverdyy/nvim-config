-- Snacks - collection of small QoL plugins
---@module "Snacks"
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = function()
    return require 'config.ui.snacks'
  end,
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    -- Additional keymaps from the original file
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent files',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Files',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Colorschemes',
    },
  },
  init = function()
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'VeryLazy',
    --   callback = function()
    --     -- Setup some globals for debugging (lazy-loaded)
    --     _G.dd = function(...)
    --       Snacks.debug.inspect(...)
    --     end
    --     _G.bt = function()
    --       Snacks.debug.backtrace()
    --     end
    --     vim.print = _G.dd
    --
    --     -- Plugin-specific keymaps that need Snacks to be loaded
    --     vim.keymap.set('n', '<leader>kt', function()
    --       local screenkey = require 'screenkey'
    --       vim.cmd 'Screenkey toggle'
    --       local screenkey_active
    --       if screenkey.is_active() then
    --         screenkey_active = ' is visible'
    --       else
    --         screenkey_active = ' is not visible'
    --       end
    --       Snacks.notify('Screenkey' .. screenkey_active)
    --     end, { desc = 'Toggle screenkey visibility' })
    --
    --     vim.keymap.set('n', '<leader>kl', function()
    --       vim.cmd 'Screenkey toggle_statusline_component'
    --     end, { desc = 'Toggle screenkey statusline component' })
    --   end,
    -- })
  end,
}
