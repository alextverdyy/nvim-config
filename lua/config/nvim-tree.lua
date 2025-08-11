-- Keymap for nvim-tree

vim.keymap.set('n', '<leader>e', function()
  local api = require 'nvim-tree.api'
  api.tree.toggle { path = '<args>', find_file = true, update_root = false, focus = true }
end, { silent = true, noremap = true, desc = 'Tree' })

-- Set up keymaps when nvim-tree buffer is created
local function on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file
      api.node.open.edit()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end

  -- open as vsplit on current node
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file as vsplit
      api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
  end

  local function opts(desc)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Custom keymaps for nvim-tree buffer
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit Or Open'))
  vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
  vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
  
  -- Default mappings
  vim.keymap.set('n', '<CR>', edit_or_open, opts('Edit Or Open'))
  vim.keymap.set('n', 'o', edit_or_open, opts('Edit Or Open'))
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
