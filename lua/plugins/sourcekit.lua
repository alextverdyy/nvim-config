return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      sourcekit = vim.loop.os_uname().sysname == 'Darwin' and {
        cmd = vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp'),
        filetypes = { 'swift' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern('Package.swift', '.git')(fname) or vim.fs.dirname(fname)
        end,
        capabilities = LazyVim.has("cmp-nvim-lsp") and require("cmp_nvim_lsp").default_capabilities() or nil,
      } or nil
    },
  },
}
