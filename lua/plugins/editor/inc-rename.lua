return {
  'smjonas/inc-rename.nvim',
  lazy = false,
  cmd = 'IncRename',
  config = function()
    require('inc_rename').setup {
      cmd_name = 'IncRename',
      hl_group = 'Substitute',
      preview_empty_name = false,
      show_message = true,
      save_in_cmdline_history = true,
      post_hook = nil,
    }
  end,
}
