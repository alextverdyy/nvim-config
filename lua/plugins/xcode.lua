--- @diagnostic disable
if vim.loop.os_uname().sysname ~= "Darwin" then
  return {}
end
return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "MunifTanjim/nui.nvim",
    "stevearc/oil.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup({})
  end,
}
