return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		shade_terminals = false,
	},
	keys = {
		{
			"<C-\\><C-\\>",
			"<CMD>ToggleTerm<CR>",
			desc = "Toggle terminal",
		},
		{
			"<C-\\>v",
			"<CMD>ToggleTerm direction=vertical size=80<CR>",
			desc = "Toggle terminal vertical",
		},
		{
			"<C-\\>s",
			"<CMD>ToggleTerm direction=horizontal<CR>",
			desc = "Toggle terminal horizontal",
		},
	},
}
