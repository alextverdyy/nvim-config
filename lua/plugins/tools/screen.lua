-- Screenkey for displaying key presses
return {
  'NStefan002/screenkey.nvim',
  lazy = false,
  version = '*',
  config = function()
    require('screenkey').setup {
      win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = 'editor',
        anchor = 'SE',
        width = 40,
        height = 3,
        border = 'single',
        title = 'Screenkey',
        title_pos = 'center',
        style = 'minimal',
        focusable = false,
        noautocmd = true,
      },
      compress_after = 3,
      clear_after = 3,
      disable = {
        filetypes = {},
        buftypes = {},
      },
      show_leader = true,
      group_mappings = false,
      display_infront = {},
      display_behind = {},
      filter = function(keys)
        return keys
      end,
      keys = {
        ['<TAB>'] = '󰌒',
        ['<CR>'] = '󰌑',
        ['<ESC>'] = 'Esc',
        ['<SPACE>'] = '󱁐',
        ['<BS>'] = '󰌥',
        ['<DEL>'] = '󰌥',
        ['<LEFT>'] = '󰌍',
        ['<RIGHT>'] = '󰌎',
        ['<UP>'] = '󰌏',
        ['<DOWN>'] = '󰌐',
      },
    }
  end,
}
