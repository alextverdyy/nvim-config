---@type snacks.Config
return {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      {
        section = 'terminal',
        cmd = 'pixterm -tc 60 -tr 17 -s 1 ~/.config/nvim/dashboard/wall.jpg',
        height = 17,
        border = 'none',
      },
      {
        pane = 2,
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
  },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    },
  },
}
