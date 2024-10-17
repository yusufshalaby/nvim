return {
	"EdenEast/nightfox.nvim",
	config = function()
		vim.cmd("colorscheme carbonfox")
		vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "rainbowcol1" })
		vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "rainbowcol2" })
		vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "rainbowcol3" })
		vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "rainbowcol4" })
		vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { link = "rainbowcol5" })
		vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { link = "rainbowcol6" })
		vim.cmd("hi @markup.italic.markdown_inline cterm=italic gui=italic")
	end,
}
