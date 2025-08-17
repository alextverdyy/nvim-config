-- Harpoon - quick file navigation
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Harpoon 2 does not require a setup call unless you want to override defaults
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
      desc = 'Select mark by index',
    },
  },
}
