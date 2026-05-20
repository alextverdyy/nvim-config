vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Exit terminal mode with double Esc
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('terminal-keymaps', { clear = true }),
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', opts)
    vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
    vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
    vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
    vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)
  end,
})
