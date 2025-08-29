return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'SmiteshP/nvim-navic' },
  config = function()
    local navic = require('nvim-navic')
    navic.setup {
      icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
      lsp = {
        auto_attach = false,
        preference = nil,
      },
      highlight = false,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = false,
      format_text = function(text)
        return text
      end,
    }
    require('lualine').setup {
      options = {
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
        globalstatus = true,
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {
          {
            'mode',
            color = function()
              local mode = vim.fn.mode()
              if mode == 'n' then     -- Normal
                return { fg = '#eed49f', bg = '', gui = 'bold' }
              elseif mode == 'i' then -- Insert
                return { fg = '#a6da95', bg = '', gui = 'bold' }
              elseif mode == 'v' then -- Visual
                return { fg = '#c6a0f6', bg = '', gui = 'bold' }
              elseif mode == 'V' then -- Visual Line
                return { fg = '#f5bde6', bg = '', gui = 'bold' }
              elseif mode == 'R' then -- Replace
                return { fg = '#f5a97f', bg = '', gui = 'bold' }
              else                    -- Other
                return { fg = '#cad3f5', bg = '', gui = 'bold' }
              end
            end,
            padding = { left = 1, right = 1 }
          },
          { 'branch', icon = '', color = { fg = '#8aadf4', bg = '', gui = 'bold' }, padding = { left = 1, right = 1 } },
        },
        lualine_b = {},
        lualine_c = {
          {
            function()
              if navic.is_available() then
                return navic.get_location()
              end
              return ''
            end,
            cond = function()
              return navic.is_available()
            end,
            color = { fg = '#c6a0f6', bg = '' }, padding = { left = 1, right = 1 },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'filetype',
            icons_enabled = true,
            colored = true,
            icon_only = false,
            color = { fg = '#8aadf4', bg = '', gui = 'bold' }, padding = { left = 1, right = 1 },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if #clients > 0 then
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return ' ' .. table.concat(names, ', ')
              else
                return ''
              end
            end,
            color = function()
              local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if #clients > 0 then
                return { fg = '#a6da95', bg = '', gui = 'bold' }
              else
                return { fg = '#f5a97f', bg = '', gui = 'bold' }
              end
            end,
            padding = { left = 1, right = 1 },
          },
          {
            function()
              return os.date('%a %d %b %H:%M')
            end,
            color = { fg = '#cad3f5', bg = '' }, padding = { left = 1, right = 1 },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {
          {
            'filetype',
            icons_enabled = true,
            colored = true,
            icon_only = false,
            color = { fg = '#8aadf4', bg = '', gui = 'bold' }, padding = { left = 1, right = 1 },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if #clients > 0 then
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return ' ' .. table.concat(names, ', ')
              else
                return ''
              end
            end,
            color = function()
              local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if #clients > 0 then
                return { fg = '#a6da95', bg = '', gui = 'bold' }
              else
                return { fg = '#f5a97f', bg = '', gui = 'bold' }
              end
            end,
            padding = { left = 1, right = 1 },
          },
          {
            function()
              return os.date('%a %d %b %H:%M')
            end,
            color = { fg = '#cad3f5', bg = '' }, padding = { left = 1, right = 1 },
          },
        },
      },
      extensions = {},
    }
  end,
}
