require("lspconfig").robotframework_ls.setup({
	cmd = { "robotframework_ls" },
	filetypes = { "robot" },
	capabilities = require("plugins.lsp.capabilities"),
	on_attach = require("plugins.lsp.on_attach"),
})

