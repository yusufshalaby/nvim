return {
	"stevearc/oil.nvim",
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Open oil",
		},
	},
	event = { "Syntax" },
	opts = {
		use_default_keymaps = false,
		keymaps = {
			["-"] = "actions.parent",
			["<C-->"] = "actions.close",
			["<CR>"] = "actions.select",
			["H"] = "actions.toggle_hidden",
			["g?"] = "actions.show_help",
			["gx"] = "actions.open_external",
			["gr"] = "actions.refresh",
			["gp"] = { "actions.preview", opts = { vertical = true, split = "botright" } }
		},
		columns = {
			"icon",
			-- "permissions",
			"size",
			-- "mtime",
		},
		view_options = {
			show_hidden = true,
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
