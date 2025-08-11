-- GitHub Copilot
return {
  'github/copilot.vim',
  cmd = 'Copilot',
  specs = {
    {
      'catppuccin',
      optional = true,
      opts = { integrations = { copilot_vim = true } },
    },
  },
}
