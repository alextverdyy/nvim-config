-- Setup

-- API components
local api = require("nvim-tree.api")

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

-- AutoCMD

api.events.subscribe(api.events.Event.FileCreated, function(file)
	vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
end)

-- Keymap

vim.keymap.set("n", "<leader>e", function()
	api.tree.toggle({ path = "<args>", find_file = true, update_root = false, focus = true })
end, { silent = true, noremap = true })

vim.keymap.set("n", "l", edit_or_open, { desc = "Edit Or Open" })
vim.keymap.set("n", "L", vsplit_preview, { desc = "Vsplit Preview" })
vim.keymap.set("n", "h", api.tree.close, { desc = "Close" })
vim.keymap.set("n", "H", api.tree.collapse_all, { desc = "Collapse All" })
