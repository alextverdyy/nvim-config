-- Overseer task runner
return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup {}
    -- Load additional configuration
    require 'config.overseer'
  end,
}
