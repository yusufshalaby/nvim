return {
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				typeCheckingMode = "standard",
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
	capabilities = require("plugins.lsp.capabilities"),
	on_attach = require("plugins.lsp.on_attach"),
}
