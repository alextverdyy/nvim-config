-- Enhanced text objects for better navigation and editing
return {
  'wellle/targets.vim',
  event = 'VeryLazy',
  config = function()
    -- Enable default settings
    vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'
  end,
}
