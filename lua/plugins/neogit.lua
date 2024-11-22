return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	keys = {
		{
			"<leader>G",
			mode = { "n" },
			function()
				require("neogit").open({kind = "split_above"})
			end,
		}
	},
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		-- "nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
		-- "echasnovski/mini.pick",         -- optional
	},
	config = true,
}
