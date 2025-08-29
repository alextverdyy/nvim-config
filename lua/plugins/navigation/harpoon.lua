-- Harpoon - quick file navigation
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Harpoon 2 does not require a setup call unless you want to override defaults
  end,
}
