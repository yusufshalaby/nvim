return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{
			"<C-n>",
			"<CMD>NvimTreeToggle<CR>",
			desc = "Open nvim-tree",
		},
	},
	version = "*",
	lazy = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
