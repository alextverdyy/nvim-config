-- LSP Configuration
return {
  -- lazydev for Lua development
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },

        { path = 'obsidian.nvim',      words = { 'Obsidian' } },
        { path = 'lazy.nvim',          words = { 'LazyVim' } },
      },
    },
  },
  -- LSPSaga for modern LSP UI
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      ui = {
        border = 'rounded',
        code_action = '',
        diagnostic = '',
        expand = '',
        collapse = '',
      },
      lightbulb = {
        enable = true,
        sign = true,
        virtual_text = false,
      },
      symbol_in_winbar = {
        enable = false, -- We'll use nvim-navic for breadcrumbs
      },
    },
  },
  -- nvim-navic for breadcrumbs
  {
    'SmiteshP/nvim-navic',
    opts = {
      highlight = true,
      separator = '  ',
      depth_limit = 5,
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    },
  },
  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    },
    config = function()
      local navic = require('nvim-navic')
      local navbuddy = require("nvim-navbuddy")
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Set buffer-local LSP keymaps from centralized file
          if _G.lsp_keymaps then
            _G.lsp_keymaps(event.buf)
          end

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Attach nvim-navic for breadcrumbs
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, event.buf)
          end

          navbuddy.attach(client, event.buf)

          -- Document highlight
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- Already handled by centralized keymaps
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        sourcekit = vim.loop.os_uname().sysname == 'Darwin' and {
          cmd = vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp'),
          filetypes = { 'swift' },
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('Package.swift', '.git')(fname) or vim.fs.dirname(fname)
          end,
          capabilities = capabilities,
        } or nil,
        ts_ls = {},
        html = {},
        cssls = {},
        clangd = {},
        pyright = {},
        ruff = {},
        bashls = {},
        gopls = {},
        zls = {},
        fish_lsp = {},
        solargraph = {},
      }


      -- Install servers
      local ensure_installed = vim.tbl_filter(function(s)
        return s ~= 'sourcekit'
      end, vim.tbl_keys(servers))

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      vim.lsp.enable 'sourcekit'
      vim.lsp.enable 'cssls'
    end,
  },
}
