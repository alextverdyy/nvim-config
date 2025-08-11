-- Project management and root detection
return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      -- Detection methods
      detection_methods = { 'lsp', 'pattern' },
      
      -- Patterns to detect root
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'Cargo.toml' },
      
      -- Don't calculate root dir on specific directories
      exclude_dirs = {},
      
      -- Show hidden files in telescope
      show_hidden = false,
      
      -- When set to false, you will get a message when project.nvim changes your directory.
      silent_chdir = true,
      
      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = 'global',
      
      -- Path where project.nvim will store the project history for use in telescope
      datapath = vim.fn.stdpath 'data',
    }
  end,
  keys = {
    { '<leader>fp', '<cmd>Telescope projects<cr>', desc = 'Find Projects' },
  },
}
