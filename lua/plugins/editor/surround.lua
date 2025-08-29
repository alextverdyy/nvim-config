-- Add/delete/replace surroundings (brackets, quotes, etc.)
local prefix = 'gz'
return {
  'echasnovski/mini.surround',
  keys = {},
  opts = {},
  specs = {
    {
      'catppuccin',
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { mini = true } },
    },
  },
}
