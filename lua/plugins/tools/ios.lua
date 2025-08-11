-- iOS development tools (Xcode integration only)
return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    ft = { 'swift', 'objc' },
    cmd = {
      'XcodebuildPicker',
      'XcodebuildBuild',
      'XcodebuildRun',
      'XcodebuildTest',
    },
    config = function()
      require('xcodebuild').setup {
        restore_on_start = true,
        auto_save = true,
        show_build_progress_bar = true,
        prepare_snapshot_test_previews = true,
        test_search = {
          file_matching = 'filename_lsp',
          target_matching = true,
          lsp_client = 'sourcekit',
          lsp_timeout = 200,
        },
        commands = {
          cache_devices = true,
        },
        integrations = {
          nvim_tree = {
            enabled = true,
            should_update_project = function(path)
              return true
            end,
          },
        },
      }

      -- iOS Development keymaps
      local map = vim.keymap.set
      local prefix = '<leader>x'
      
      -- Xcode/iOS keymaps
      map('n', prefix, '', { desc = '📱 iOS Development' })
      map('n', prefix .. 'p', '<cmd>XcodebuildPicker<cr>', { desc = 'Show picker' })
      map('n', prefix .. 'b', '<cmd>XcodebuildBuild<cr>', { desc = 'Build project' })
      map('n', prefix .. 'r', '<cmd>XcodebuildRun<cr>', { desc = 'Run project' })
      map('n', prefix .. 't', '<cmd>XcodebuildTest<cr>', { desc = 'Run tests' })
      map('n', prefix .. 'c', '<cmd>XcodebuildClean<cr>', { desc = 'Clean build' })
      map('n', prefix .. 's', '<cmd>XcodebuildSelectScheme<cr>', { desc = 'Select scheme' })
      map('n', prefix .. 'd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select device' })
      map('n', prefix .. 'q', '<cmd>XcodebuildQuickfix<cr>', { desc = 'Show quickfix' })
    end,
  },
}
