-- QMK keyboard configuration
-- This plugin provides tools for working with QMK firmware in Neovim
-- Disabled by default, enable it if you work with QMK keyboards
-- and want to use Neovim for editing QMK firmware files.
-- You can customize the setup as needed.
-- For more information, refer to the plugin's documentation:
-- --
if true then return {} end
return {
  'codethread/qmk.nvim',
  config = function()
    require('qmk').setup {}
  end,
}
