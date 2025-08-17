-- Visual indicators for vim modes
return {
  'rasulomaroff/reactive.nvim',
  lazy = false,
  config = function()
    require('reactive').setup {
      load = { 'catppuccin-mocha-cursor', 'catppuccin-mocha-cursorline' },
    }
  end,
}
