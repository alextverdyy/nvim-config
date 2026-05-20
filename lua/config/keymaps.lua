-- General
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode' })
vim.keymap.set('v', ';', ':', { desc = 'Enter command mode' })
vim.keymap.set('n', ':', ';', { desc = 'Repeat f/F/t/T motion' })

-- Incremental rename
vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = 'Incremental Rename' })

-- Line movement (gomove)
local move_opts = { silent = true, noremap = true }
for key, dir in pairs { h = 'Left', j = 'Down', k = 'Up', l = 'Right' } do
  vim.keymap.set('n', '<S-' .. key .. '>', '<Plug>GoNSM' .. dir,
    vim.tbl_extend('force', move_opts, { desc = 'Move line ' .. dir }))
  vim.keymap.set('x', '<S-' .. key .. '>', '<Plug>GoVSM' .. dir,
    vim.tbl_extend('force', move_opts, { desc = 'Move block ' .. dir }))
end

-- CodeCompanion
vim.keymap.set({ 'n', 'v' }, '<leader>A', '', { desc = 'CodeCompanion' })
vim.keymap.set({ 'n', 'v' }, '<leader>Ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>Aa', '<cmd>CodeCompanionActions<cr>', { desc = 'Actions' })
