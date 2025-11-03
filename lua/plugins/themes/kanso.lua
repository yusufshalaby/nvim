return {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanso").setup({
			background = { -- map the value of 'background' option to a theme
				dark = "zen", -- try "zen", "mist" or "pearl" !
				light = "zen" -- try "zen", "mist" or "pearl" !
			},
		})
		vim.cmd("colorscheme kanso")
	end
}
