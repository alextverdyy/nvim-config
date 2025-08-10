return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      -- Harpoon 2 does not require a setup call unless you want to override defaults.
    end,
    keys = {
      {
        '<leader><leader>',
        group = '󱡀 Harpoon',
        desc = 'Harpoon',
      },
      {
        '<leader><leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Add file',
      },
      {
        '<leader><leader>e',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = 'Toggle quick menu',
      },
      {
        '<C-x>',
        function()
          vim.ui.input({ prompt = 'Harpoon mark index: ' }, function(input)
            local num = tonumber(input)
            if num then
              require('harpoon'):list():select(num)
            end
          end)
        end,
        desc = 'Goto index of mark',
      },
      {
        '<C-p>',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Goto previous mark',
      },
      {
        '<C-n>',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'Goto next mark',
      },
      {
        '<leader><leader>m',
        '<Cmd>Telescope harpoon marks<CR>',
        desc = 'Show marks in Telescope',
      },
      {
        '<leader><leader>t',
        function()
          local term_string = vim.fn.exists '$TMUX' == 1 and 'tmux' or 'term'
          vim.ui.input({ prompt = term_string .. ' window number: ' }, function(input)
            local num = tonumber(input)
            if num then
              require('harpoon').term.gotoTerminal(num)
            end
          end)
        end,
        desc = 'Go to terminal window',
      },
    },
  },
  {
    'letieu/harpoon-lualine',
    lazy = true,
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
}
