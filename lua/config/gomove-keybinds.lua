-- gomove-keymaps.lua
-- Custom keymaps for gomove.nvim
-- Modernized to use vim.keymap.set, loops, and descriptions

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Directions
local directions = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

-- Smart Move mappings (<S-...>)
for key, dir in pairs(directions) do
  map(
    'n',
    '<S-' .. key .. '>',
    '<Plug>GoNSM' .. dir,
    vim.tbl_extend('force', opts, {
      desc = 'GoMove: Smart Move ' .. dir .. ' (Normal)',
    })
  )
  map(
    'x',
    '<S-' .. key .. '>',
    '<Plug>GoVSM' .. dir,
    vim.tbl_extend('force', opts, {
      desc = 'GoMove: Smart Move ' .. dir .. ' (Visual)',
    })
  )
end

-- Smart Duplicate mappings (<C-...>)
for key, dir in pairs(directions) do
  map(
    'n',
    '<C-' .. key .. '>',
    '<Plug>GoNSD' .. dir,
    vim.tbl_extend('force', opts, {
      desc = 'GoMove: Smart Duplicate ' .. dir .. ' (Normal)',
    })
  )
  map(
    'x',
    '<C-' .. key .. '>',
    '<Plug>GoVSD' .. dir,
    vim.tbl_extend('force', opts, {
      desc = 'GoMove: Smart Duplicate ' .. dir .. ' (Visual)',
    })
  )
end
