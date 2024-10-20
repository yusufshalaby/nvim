-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	-- gopls = {},
	pyright = {
		pyright = { autoImportCompletion = true },
		python = {
			-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
			analysis = {
				autoSearchPaths = true,
				typeCheckingMode = "basic",
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				diagnosticSeverityOverrides = {
					-- reportGeneralTypeIssues = "none",
					--   reportOptionalMemberAccess = "none",
					--   reportOptionalSubscript = "none",
					--   reportPrivateImportUsage = "none",
				},
			},
		},
	},
	-- ruff_lsp = {},
	lua_ls = {}, -- TJ Devries lua lsp setup: https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
	marksman = {},
	html = {},
}

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = require("plugins.lsp.capabilities"),
			on_attach = require("plugins.lsp.on_attach"),
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

