return {
  "ruifm/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {},
  keys = {
    { "<leader>gy", "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>", desc = "Git Link" },
    { "<leader>gy", "<cmd>lua require'gitlinker'.get_buf_range_url('v')<cr>", mode = "v", desc = "Git Link" },
  },
}
