return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", version = "1.11.0", opts = { ui = { border = "rounded" } } },
		{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("plugins.lsp.lspconfig.mason")
		require("plugins.lsp.lspconfig.languages.init")
	end,
}
