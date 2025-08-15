return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("let g:gruvbox_material_background = 'medium'")
		vim.cmd("let g:gruvbox_material_foreground = 'material'")
		vim.cmd("let g:gruvbox_material_better_performance = 1")
		vim.cmd("let g:gruvbox_material_float_style = 'dim'")
		vim.cmd("colorscheme gruvbox-material")
		vim.cmd("hi CursorLineNr guifg=#d8a657")
		vim.cmd("hi @markup.italic.markdown_inline cterm=italic gui=italic")
		vim.cmd("hi NormalFloat guibg=NONE")
		vim.cmd("hi FloatBorder guibg=NONE")
		vim.cmd("hi FloatTitle guibg=NONE")
	end,
}
