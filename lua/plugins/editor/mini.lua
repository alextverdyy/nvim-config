-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- Disabled in favor of nvim-surround
    -- require('mini.surround').setup()

    -- Simple and easy statusline - disabled in favor of lualine
    -- require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
  end,
}
