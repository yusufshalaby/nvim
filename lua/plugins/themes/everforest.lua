return {
	"sainnhe/everforest",
	config = function()
		vim.cmd("let g:everforest_background = 'medium'")
		vim.cmd("let g:everforest_better_performance = 1")
		vim.cmd("let g:everforest_float_style = 'dim'")
		vim.cmd("colorscheme everforest")
		vim.cmd("hi NormalFloat guibg=NONE")
		vim.cmd("hi FloatBorder guibg=NONE")
		vim.cmd("hi FloatTitle guibg=NONE")
	end,
}
