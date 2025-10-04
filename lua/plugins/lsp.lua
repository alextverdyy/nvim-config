return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      lua_ls = {},
      sourcekit = {},
      bashls = {},
      rust_analyzer = {},
      basedpyright = {},
      fish_lsp = {},
    },
  },
}
