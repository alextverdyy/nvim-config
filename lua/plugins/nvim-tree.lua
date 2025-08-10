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
    }
  end,
}
