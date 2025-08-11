-- Nvim-tree file explorer
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    require('nvim-tree').setup {
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          quit_on_open = true, -- This will close nvim-tree when a file is opened
        },
      },
      view = {
        width = 30,
      },
    }

    -- Load additional configuration
    require('config.nvim-tree')
  end,
}
