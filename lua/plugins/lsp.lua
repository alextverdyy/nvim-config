return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "K", require("hover").open }
    opts.inlay_hints = { enabled = false }
    opts.servers = {
      lua_ls = {},
      sourcekit = {},
      bashls = {},
      rust_analyzer = {},
      basedpyright = {},
      fish_lsp = {},
    }
  end,
}
