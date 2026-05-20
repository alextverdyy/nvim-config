-- Swift/Xcode stack — macOS only
if vim.fn.has 'mac' == 0 then
  return {}
end

return {
  -- Swift language syntax
  {
    'keith/swift.vim',
    ft = 'swift',
    config = function()
      vim.g.swift_no_conceal = 1
    end,
  },
  -- sourcekit-lsp wiring (native vim.lsp.config)
  {
    'neovim/nvim-lspconfig',
    optional = true,
    config = function()
      vim.lsp.config('sourcekit', {
        cmd = { vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp 2>/dev/null') },
        filetypes = { 'swift', 'objc', 'objcpp' },
        root_markers = { 'Package.swift', '.git', '*.xcodeproj', '*.xcworkspace' },
      })
      vim.lsp.enable 'sourcekit'
    end,
  },
  -- xcodebuild.nvim
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = { 'swift', 'objc' },
    cmd = {
      'XcodebuildPicker', 'XcodebuildBuild', 'XcodebuildRun',
      'XcodebuildTest', 'XcodebuildClean',
    },
    keys = {
      { '<leader>X',     '<cmd>XcodebuildPicker<cr>',             desc = 'Xcodebuild Actions' },
      { '<leader>xf',    '<cmd>XcodebuildProjectManager<cr>',     desc = 'Project Manager' },
      { '<leader>xb',    '<cmd>XcodebuildBuild<cr>',              desc = 'Build Project' },
      { '<leader>xB',    '<cmd>XcodebuildBuildForTesting<cr>',    desc = 'Build For Testing' },
      { '<leader>xr',    '<cmd>XcodebuildBuildRun<cr>',           desc = 'Build & Run' },
      { '<leader>xt',    '<cmd>XcodebuildTest<cr>',               desc = 'Run Tests' },
      { '<leader>xt',    '<cmd>XcodebuildTestSelected<cr>',       mode = 'v', desc = 'Run Selected Tests' },
      { '<leader>xT',    '<cmd>XcodebuildTestClass<cr>',          desc = 'Run Test Class' },
      { '<leader>x.',    '<cmd>XcodebuildTestRepeat<cr>',         desc = 'Repeat Last Test' },
      { '<leader>xl',    '<cmd>XcodebuildToggleLogs<cr>',         desc = 'Toggle Logs' },
      { '<leader>xc',    '<cmd>XcodebuildToggleCodeCoverage<cr>', desc = 'Toggle Code Coverage' },
      { '<leader>xC',    '<cmd>XcodebuildShowCodeCoverageReport<cr>', desc = 'Coverage Report' },
      { '<leader>xe',    '<cmd>XcodebuildTestExplorerToggle<cr>', desc = 'Toggle Test Explorer' },
      { '<leader>xs',    '<cmd>XcodebuildFailingSnapshots<cr>',   desc = 'Failing Snapshots' },
      { '<leader>xd',    '<cmd>XcodebuildSelectDevice<cr>',       desc = 'Select Device' },
      { '<leader>xx',    '<cmd>XcodebuildQuickfixLine<cr>',       desc = 'Quickfix Line' },
      { '<leader>xa',    '<cmd>XcodebuildCodeActions<cr>',        desc = 'Code Actions' },
      { '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>',      desc = 'Toggle Preview' },
    },
    config = function()
      require('xcodebuild').setup {
        restore_on_start = true,
        auto_save = true,
        show_build_progress_bar = true,
        test_search = {
          file_matching = 'filename_lsp',
          target_matching = true,
          lsp_client = 'sourcekit',
          lsp_timeout = 200,
        },
        logs = {
          auto_open_on_failed_build = true,
          auto_focus = true,
          live_logs = true,
          show_warnings = true,
        },
        test_explorer = {
          enabled = true,
          auto_open = true,
          auto_focus = true,
          open_command = 'botright 42vsplit Test Explorer',
        },
      }
    end,
  },
  -- DAP for Swift debugging
  {
    'mfussenegger/nvim-dap',
    ft = 'swift',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      { 'nvim-neotest/nvim-nio' },
    },
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end,                                      desc = 'Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Condition: ') end,               desc = 'Conditional Breakpoint' },
      { '<leader>dc', function() require('dap').continue() end,                                               desc = 'Continue' },
      { '<leader>dn', function() require('dap').step_over() end,                                              desc = 'Step Over' },
      { '<leader>ds', function() require('dap').step_into() end,                                              desc = 'Step Into' },
      { '<leader>do', function() require('dap').step_out() end,                                               desc = 'Step Out' },
      { '<leader>dr', function() require('dap').repl.open() end,                                              desc = 'Open REPL' },
      { '<leader>dl', function() require('dap').run_last() end,                                               desc = 'Run Last' },
      { '<leader>du', function() require('dapui').toggle() end,                                               desc = 'Toggle DAP UI' },
      { '<leader>dq', function() require('dap').terminate() end,                                              desc = 'Terminate' },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()
      require('nvim-dap-virtual-text').setup()

      dap.adapters.swift = { type = 'server', host = '127.0.0.1', port = 7777 }
      dap.configurations.swift = {
        {
          type = 'swift', request = 'launch', name = 'Launch Swift',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
