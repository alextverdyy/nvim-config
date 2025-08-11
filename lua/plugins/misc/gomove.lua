-- Gomove - move lines and blocks
return {
  'booperlv/nvim-gomove',
  config = function()
    require('gomove').setup {}
    -- Load additional keybinds
    require('config.gomove-keybinds')
  end,
}
