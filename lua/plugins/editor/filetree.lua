return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
	dependencies = {
		"echasnovski/mini.icons",
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
		{ "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
	},
	opts = {
		open_file = {
			quit_on_open = false,
			eject = true,
			resize_window = true,
			relative_path = true,
			window_picker = {
				enable = true,
				picker = "default",
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},

		update_focused_file = {
			enable = true,
			update_root = true,
		},
		view = {
			adaptive_size = true,
			side = "left",
			width = 30,
			preserve_window_proportions = true,
		},
		git = {
			enable = true,
			ignore = true,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = true,
			},
		},
	},
}
