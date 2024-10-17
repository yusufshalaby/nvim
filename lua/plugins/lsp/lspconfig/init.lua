return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
		"williamboman/mason-lspconfig.nvim",
		"nvimtools/none-ls.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"folke/neodev.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("neodev").setup()
		require("plugins.lsp.lspconfig.mason")
		require("plugins.lsp.lspconfig.null-ls")
		require("plugins.lsp.lspconfig.languages.init")
	end,
}
