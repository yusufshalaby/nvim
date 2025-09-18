return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
		local on_attach = require("plugins.lsp.on_attach")
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				-- Prevent double-running if you also set on_attach elsewhere
				if vim.b[bufnr].__did_universal_on_attach then
					return
				end
				vim.b[bufnr].__did_universal_on_attach = true

				on_attach(client, bufnr)
			end,
		})
	end,
}
