return {
  'github/copilot.vim',
  cmd = 'Copilot',
  specs = {
    {
      'catppuccin',
      optional = true,
      ---@module 'catppuccin'
      ---@type CatppuccinOptions
      opts = { integrations = { copilot_vim = true } },
    },
  },
}
