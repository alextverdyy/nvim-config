-- Nvim-tree keymaps are now centralized in core/keymaps.lua
-- This file only provides the on_attach function to call the centralized keymaps

local function on_attach(bufnr)
  if _G.nvim_tree_keymaps then _G.nvim_tree_keymaps(bufnr) end
end

-- AutoCMD for file creation
local api = require 'nvim-tree.api'
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd('edit ' .. vim.fn.fnameescape(file.fname))
end)

-- Return the on_attach function so it can be used in setup
return {
  on_attach = on_attach,
}
