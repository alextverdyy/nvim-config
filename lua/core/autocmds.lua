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

-- Handle Snacks windows on quit
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    local snacks_windows = {}
    local floating_windows = {}
    local windows = vim.api.nvim_list_wins()
    for _, w in ipairs(windows) do
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
      if filetype:match 'snacks_' ~= nil then
        table.insert(snacks_windows, w)
      elseif vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_windows, w)
      end
    end
    if 1 == #windows - #floating_windows - #snacks_windows then
      -- Should quit, so we close all Snacks windows.
      for _, w in ipairs(snacks_windows) do
        vim.api.nvim_win_close(w, true)
      end
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
