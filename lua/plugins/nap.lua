return {
  'liangxianzhe/nap.nvim',
  lazy = false,
  config = function()
    require('nap').setup {
      next_prefix = ']',
      prev_prefix = '[',
      next_repeat = '<c-n>',
      prev_repeat = '<c-p>',
      exclude_default_operators = { 'a', 'A' },
    }
  end,
}
