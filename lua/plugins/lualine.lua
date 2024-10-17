return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		options = {
			icons_enabled = true,
			globalstatus = true,
			theme = "auto",
			component_separators = "|",
			section_separators = "",
		},
	},
}
