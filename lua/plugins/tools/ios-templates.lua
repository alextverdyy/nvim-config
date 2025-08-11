-- iOS development environment (no templates)
return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').load_extension 'file_browser'
      
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', { desc = 'File browser' })
    end,
  },
}
