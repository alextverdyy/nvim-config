return {
  -- cosec-twilight colorscheme (+ lush)
  {
    'alextverdyy/cosec-twilight.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      local ok = pcall(vim.cmd.colorscheme, 'cosec-twilight')
      if not ok then
        vim.cmd.colorscheme 'habamax'
      end
    end,
  },
  -- Alternative colorschemes (lazy-loaded, switch with :colorscheme)
  { 'scottmckendry/cyberdream.nvim', lazy = true },
  { 'catppuccin/nvim',               name = 'catppuccin', lazy = true },
  -- Noice: better cmdline, messages, popupmenu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      presets = { inc_rename = true },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
  },
  -- Statusline: lualine + navic breadcrumbs
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'SmiteshP/nvim-navic' },
    config = function()
      local navic = require 'nvim-navic'
      require('lualine').setup {
        options = {
          icons_enabled = true,
          section_separators = '',
          component_separators = '',
          globalstatus = true,
          disabled_filetypes = { 'dashboard' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              color = function()
                local colors = {
                  n = '#eed49f', i = '#a6da95', v = '#c6a0f6',
                  V = '#f5bde6', R = '#f5a97f',
                }
                return { fg = colors[vim.fn.mode()] or '#cad3f5', bg = '', gui = 'bold' }
              end,
              padding = { left = 1, right = 1 },
            },
            { 'branch', icon = '', color = { fg = '#8aadf4', bg = '', gui = 'bold' }, padding = 1 },
          },
          lualine_b = {},
          lualine_c = {
            {
              function()
                return navic.is_available() and navic.get_location() or ''
              end,
              cond = function() return navic.is_available() end,
              color = { fg = '#c6a0f6', bg = '' },
              padding = 1,
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              'filetype',
              icons_enabled = true,
              colored = true,
              color = { fg = '#8aadf4', bg = '', gui = 'bold' },
              padding = 1,
            },
            {
              function()
                local clients = vim.lsp.get_clients { bufnr = 0 }
                if #clients == 0 then return '' end
                local names = vim.tbl_map(function(c) return c.name end, clients)
                return ' ' .. table.concat(names, ', ')
              end,
              color = function()
                local active = #vim.lsp.get_clients { bufnr = 0 } > 0
                return { fg = active and '#a6da95' or '#f5a97f', bg = '', gui = 'bold' }
              end,
              padding = 1,
            },
            {
              function() return os.date '%a %d %b %H:%M' end,
              color = { fg = '#cad3f5', bg = '' },
              padding = 1,
            },
          },
        },
        inactive_sections = {
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
        },
        extensions = {},
      }
    end,
  },
  -- Highlight colors (CSS hex, rgb, etc.)
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'BufReadPre',
    config = function()
      require('nvim-highlight-colors').setup {}
    end,
  },
}
