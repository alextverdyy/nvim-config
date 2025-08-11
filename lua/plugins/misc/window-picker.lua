-- Window picker for easy window navigation
return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup {
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
          -- if the buffer type is one of following, the window will be ignored
          buftype = { 'terminal', 'quickfix' },
        },
      },
    }

    vim.keymap.set('n', '<leader>wp', function()
      local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(picked_window_id)
    end, { desc = 'Pick a window' })
  end,
}
