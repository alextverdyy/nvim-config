-- Modern dashboard for Neovim using dashboard-nvim
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          { icon = ' ', icon_hl = '@variable', desc = 'Files', group = 'Label', action = 'FzfLua files', key = 'f' },
          { desc = ' Buffers', group = 'DiagnosticHint', action = 'FzfLua buffers', key = 'b' },
          { desc = ' Projects', group = 'Number', action = 'FzfLua oldfiles', key = 'p' },
        },
        packages = { enable = true },
        project = { enable = true, limit = 8, icon = '', label = '  Projects', action = 'FzfLua files' },
        mru = { enable = true, limit = 10, icon = '', label = '  Recent files', cwd_only = false },
        footer = { '', '', 'Neovim dashboard ready!' },

        background = {
          enabled = false
        }
      },
    }
    -- Desactivar visualización de caracteres invisibles y plugins de indentación en el dashboard
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dashboard',
      callback = function()
        vim.opt_local.list = false
        if package.loaded['ibl'] then
          require('ibl').setup_buffer(0, { enabled = false })
        end
        if package.loaded['mini.indentscope'] then
          vim.b.miniindentscope_disable = true
        end
      end,
    })
    -- Actualiza el footer con estadísticas de Lazy.nvim al final del arranque
    vim.schedule(function()
      local ok, lazy = pcall(require, 'lazy')
      if ok and lazy.stats then
        local stats = lazy.stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        require('dashboard').setup {
          theme = 'hyper',
          config = {
            week_header = { enable = true },
            shortcut = {
              { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
              { icon = ' ', icon_hl = '@variable', desc = 'Files', group = 'Label', action = 'FzfLua files', key = 'f' },
              { desc = ' Buffers', group = 'DiagnosticHint', action = 'FzfLua buffers', key = 'b' },
              { desc = ' Projects', group = 'Number', action = 'FzfLua oldfiles', key = 'p' },
            },
            packages = { enable = false },
            project = { enable = true, limit = 8, icon = '', label = '  Projects', action = 'FzfLua files' },
            mru = { enable = true, limit = 10, icon = '', label = '  Recent files', cwd_only = false },
            footer = {
              '', '', 'Neovim dashboard ready!', '',
              '⚡ Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
            },
            background = {
              enabled = false
            }
          },
        }
      end
    end)
  end,
}
