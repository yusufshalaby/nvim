require("lspconfig").ruby_lsp.setup({
	filetypes = { "ruby" },
	capabilities = require("plugins.lsp.capabilities"),
	on_attach = require("plugins.lsp.on_attach"),
	init_options = {
		formatter = "standard",
		linters = { "standard" },
	},
})

-- require("lspconfig").sorbet.setup({
-- 	filetypes = { "ruby" },
-- 	cmd = { "srb", "tc", "--lsp", "--typed", "true" },
-- 	root_dir = function(fname)
-- 		return require("lspconfig.util").root_pattern("sorbet/config")(fname) or vim.fn.getcwd()
-- 	end,
-- 	capabilities = require("plugins.lsp.capabilities"),
-- 	on_attach = require("plugins.lsp.on_attach"),
-- })
--
-- require("lspconfig").solargraph.setup({
-- 	cmd = {
-- 		"asdf",
-- 		"exec",
-- 		"solargraph",
-- 		"stdio",
-- 	},
-- 	filetypes = { "ruby" },
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

