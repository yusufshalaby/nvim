return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("plugins.lsp.lspconfig.mason")
		require("plugins.lsp.lspconfig.languages.init")
	end,
}
