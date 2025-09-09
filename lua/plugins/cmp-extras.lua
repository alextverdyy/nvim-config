return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "chrisgrieser/cmp-nerdfont" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "nerdfont" })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("blink-cmp").setup({
        sources = {
          { name = "blink_cmp" },
          { name = "nvim_lsp" },
        },
      })
    end,
  },
}
