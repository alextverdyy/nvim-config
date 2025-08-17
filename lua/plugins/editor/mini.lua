-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
  end,
}
