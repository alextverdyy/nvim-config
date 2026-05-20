return {
  -- Lua development
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
  -- Mason: install/manage LSP binaries
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    opts = {},
  },
  -- Bridge mason → native vim.lsp.enable
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls', 'ts_ls', 'html', 'cssls', 'clangd',
        'pyright', 'ruff', 'bashls', 'gopls', 'zls',
      },
      automatic_enable = true,
    },
  },
  -- JSON/YAML schemas
  { 'b0o/schemastore.nvim', lazy = true },
  -- LSP progress indicator
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
  -- navic for breadcrumbs in lualine
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    opts = {
      highlight = true,
      separator = '  ',
      depth_limit = 5,
    },
  },
  -- Main LSP configuration using native 0.11 API
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'folke/lazydev.nvim',
      'saghen/blink.cmp',
      'b0o/schemastore.nvim',
      'j-hui/fidget.nvim',
      'SmiteshP/nvim-navic',
    },
    config = function()
      -- Global capabilities (blink.cmp)
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Per-server config overrides
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = { completion = { callSnippet = 'Replace' } },
        },
      })

      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = '' },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      })

      -- tmux language server
      vim.lsp.config('tmux', {
        cmd = { 'tmux-language-server' },
        filetypes = { 'tmux' },
        root_markers = { '.tmux.conf', 'tmux.conf' },
      })

      -- sourcekit-lsp wiring (macOS only) — handled in xcode plugin

      -- Diagnostic display
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
        virtual_text = { source = 'if_many', spacing = 2 },
      }

      -- LspAttach: keymaps + navic + document highlight
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('<leader>D', vim.lsp.buf.declaration, 'Goto Declaration')
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
          end, 'Toggle Inlay Hints')

          -- navic breadcrumbs
          if client and client.server_capabilities.documentSymbolProvider then
            pcall(require('nvim-navic').attach, client, bufnr)
          end

          -- Document highlight
          if client and client:supports_method('textDocument/documentHighlight', bufnr) then
            local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = e.buf }
              end,
            })
          end
        end,
      })
    end,
  },
}
