-- iOS project management and utilities
return {
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        -- Detection methods
        detection_methods = { 'lsp', 'pattern' },
        
        -- Patterns for iOS projects
        patterns = {
          '.git',
          '_darcs',
          '.hg',
          '.bzr',
          '.svn',
          'Makefile',
          'package.json',
          '*.xcodeproj',       -- Xcode projects
          '*.xcworkspace',     -- Xcode workspaces
          'Package.swift',     -- Swift Package Manager
          'Podfile',           -- CocoaPods
          'Cartfile',          -- Carthage
          'project.pbxproj',   -- Xcode project file
        },
        
        -- Don't calculate root dir on specific directories
        exclude_dirs = { '~/Downloads/*' },
        
        -- Show hidden files in telescope
        show_hidden = false,
        
        -- When set to false, you will get a message when project.nvim changes your directory.
        silent_chdir = true,
        
        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'global',
      }

      -- Telescope integration
      require('telescope').load_extension('projects')
      
      -- Project keymaps
      vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = 'Find projects' })
    end,
  },
  {
    'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup {
        templates = { 'builtin', 'ios' },
        strategy = {
          'toggleterm',
          direction = 'horizontal',
          autos_croll = true,
          quit_on_exit = 'never'
        },
      }

      -- iOS specific task templates
      require('overseer').register_template {
        name = 'ios build',
        builder = function()
          return {
            cmd = { 'xcodebuild' },
            args = { '-workspace', '*.xcworkspace', '-scheme', 'YourScheme', 'build' },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { 'swift' },
        },
      }

      require('overseer').register_template {
        name = 'ios test',
        builder = function()
          return {
            cmd = { 'xcodebuild' },
            args = { 'test', '-workspace', '*.xcworkspace', '-scheme', 'YourScheme' },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { 'swift' },
        },
      }

      require('overseer').register_template {
        name = 'swift package build',
        builder = function()
          return {
            cmd = { 'swift' },
            args = { 'build' },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable('Package.swift') == 1
          end,
        },
      }

      require('overseer').register_template {
        name = 'swift package test',
        builder = function()
          return {
            cmd = { 'swift' },
            args = { 'test' },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable('Package.swift') == 1
          end,
        },
      }

      -- CocoaPods tasks
      require('overseer').register_template {
        name = 'pod install',
        builder = function()
          return {
            cmd = { 'pod' },
            args = { 'install' },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable('Podfile') == 1
          end,
        },
      }

      -- Overseer keymaps
      local map = vim.keymap.set
      local task_prefix = '<leader>o'
      
      map('n', task_prefix, '', { desc = '⚙️  Tasks' })
      map('n', task_prefix .. 'r', '<cmd>OverseerRun<cr>', { desc = 'Run task' })
      map('n', task_prefix .. 't', '<cmd>OverseerToggle<cr>', { desc = 'Toggle tasks' })
      map('n', task_prefix .. 'a', '<cmd>OverseerTaskAction<cr>', { desc = 'Task actions' })
      map('n', task_prefix .. 'i', '<cmd>OverseerInfo<cr>', { desc = 'Task info' })
      map('n', task_prefix .. 'b', '<cmd>OverseerBuild<cr>', { desc = 'Build task' })
      map('n', task_prefix .. 'q', '<cmd>OverseerQuickAction<cr>', { desc = 'Quick action' })
    end,
  },
}
