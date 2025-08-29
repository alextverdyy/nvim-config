-- Core autocommands
-- This file contains general autocommands that are not plugin-specific

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'dashboard' then
      vim.opt_local.list = false
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.listchars = { space = '', tab = '', eol = '', trail = '' }
    end
  end,
})

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
  nested = false,
  callback = function(e)
    local ok, tree_api = pcall(require, 'nvim-tree.api')
    if not ok then
      return
    end

    local tree = tree_api.tree

    -- Nothing to do if tree is not opened
    if not tree.is_visible() then
      return
    end

    -- How many focusable windows do we have?
    local winCount = 0
    for _, winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then
        winCount = winCount + 1
      end
    end

    -- We want to quit and only one window besides tree is left
    if e.event == 'QuitPre' and winCount == 2 then
      vim.api.nvim_cmd({ cmd = 'qall' }, {})
    end

    -- :bd was probably issued an only tree window is left
    if e.event == 'BufEnter' and winCount == 1 then
      vim.defer_fn(function()
        tree.toggle { find_file = true, focus = true }
        tree.toggle { find_file = true, focus = false }
      end, 10)
    end
  end,
})

-- Language server for tmux configuration files
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { 'tmux.conf', '.tmux.conf' },
  callback = function()
    vim.lsp.start {
      name = 'tmux',
      cmd = { 'tmux-language-server' },
    }
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  desc = 'Unlink current snippet on leaving insert/selection mode.',
  group = vim.api.nvim_create_augroup('LuaSnipModeChanged', {}),
  pattern = '[si]*:[^si]*',
  callback = vim.schedule_wrap(function(args)
    local ls = require 'luasnip'

    if vim.fn.mode():match '^[si]' then -- still in insert/select mode
      return
    end
    if ls.session.current_nodes[args.buf] and not ls.session.jump_active then
      ls.unlink_current()
    end
  end),
})
