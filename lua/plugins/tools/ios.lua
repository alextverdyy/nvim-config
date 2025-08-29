-- iOS development tools (Xcode integration only)
if vim.loop.os_uname().sysname ~= 'Darwin' then
  return {}
end
return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
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
          extra_build_args = { '-parallelizeTargets' },
          extra_test_args = { '-parallelizeTargets' },
          project_search_max_depth = 4,
          focus_simulator_on_app_launch = true,
          keep_device_cache = false,
        },
        logs = {
          auto_open_on_failed_build = true,
          auto_focus = true,
          logs_formatter = 'xcbeautify --disable-colored-output --disable-logging',
          live_logs = true,
          show_warnings = true,
        },
        quickfix = {
          show_errors_on_quickfixlist = true,
          show_warnings_on_quickfixlist = true,
        },
        test_explorer = {
          enabled = true,
          auto_open = true,
          auto_focus = true,
          open_command = 'botright 42vsplit Test Explorer',
          open_expanded = true,
        },
        code_coverage = {
          enabled = false,
          file_pattern = '*.swift',
        },
        integrations = {
          nvim_tree = { enabled = true },
          fzf_lua = { enabled = true },
          quick = { enabled = true },
        },
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

      -- iOS Development keymaps (full set, per official docs)
      local map = vim.keymap.set
      map('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show Xcodebuild Actions' })
      map('n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', { desc = 'Show Project Manager Actions' })
      map('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
      map('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = 'Build For Testing' })
      map('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
      map('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
      map('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })
      map('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run Current Test Class' })
      map('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Repeat Last Test Run' })
      map('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
      map('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
      map('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code Coverage Report' })
      map('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Toggle Test Explorer' })
      map('n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show Failing Snapshots' })
      map('n', '<leader>xp', '<cmd>XcodebuildPreviewGenerateAndShow<cr>', { desc = 'Generate Preview' })
      map('n', '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Toggle Preview' })
      map('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
      map('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
      map('n', '<leader>xx', '<cmd>XcodebuildQuickfixLine<cr>', { desc = 'Quickfix Line' })
      map('n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', { desc = 'Show Code Actions' })
    end,
  },
}
