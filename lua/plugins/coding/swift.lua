-- Swift language support and development tools
return {
  {
    'keith/swift.vim',
    ft = 'swift',
    config = function()
      -- Swift specific settings
      vim.g.swift_no_conceal = 1
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    ft = 'swift',
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      -- Setup DAP UI
      dapui.setup()
      
      -- Setup virtual text
      require('nvim-dap-virtual-text').setup()

      -- Swift debugging configuration
      dap.adapters.swift = {
        type = 'server',
        host = '127.0.0.1',
        port = 7777,
      }

      dap.configurations.swift = {
        {
          type = 'swift',
          request = 'launch',
          name = 'Launch Swift Program',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      -- Debug keymaps
      local map = vim.keymap.set
      local debug_prefix = '<leader>d'
      
      map('n', debug_prefix, '', { desc = '🐛 Debug' })
      map('n', debug_prefix .. 'b', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
      map('n', debug_prefix .. 'B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'Conditional breakpoint' })
      map('n', debug_prefix .. 'c', dap.continue, { desc = 'Continue' })
      map('n', debug_prefix .. 'n', dap.step_over, { desc = 'Step over' })
      map('n', debug_prefix .. 's', dap.step_into, { desc = 'Step into' })
      map('n', debug_prefix .. 'o', dap.step_out, { desc = 'Step out' })
      map('n', debug_prefix .. 'r', dap.repl.open, { desc = 'Open REPL' })
      map('n', debug_prefix .. 'l', dap.run_last, { desc = 'Run last' })
      map('n', debug_prefix .. 'u', dapui.toggle, { desc = 'Toggle UI' })
      map('n', debug_prefix .. 'q', dap.terminate, { desc = 'Quit debug session' })
      
      -- Auto open/close UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
