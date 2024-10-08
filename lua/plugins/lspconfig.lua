local M = {}

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" })

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", "<cmd> Trouble toggle lsp_definitions <CR>", "[G]oto [D]efinition")
	nmap("gr", "<cmd> Trouble toggle lsp_references <CR>", "[G]oto [R]eferences")
	nmap("gI", "<cmd> Trouble toggle lsp_implementations <CR>", "[G]oto [I]mplementation")
	nmap("<leader>gD", "<cmd> Trouble toggle lsp_type_definitions <CR>", "[G]oto type [D]efinition")
	nmap("<leader>ds", "<cmd> Trouble toggle symbols <CR>", "[D]ocument [S]ymbols")
	nmap("<leader>ws", "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	vim.keymap.set({ "n", "i" }, "<A-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

end

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

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

require("lspconfig").solargraph.setup({
	cmd = {
		"asdf",
		"exec",
		"solargraph",
		"stdio",
	},
	filetypes = { "ruby" },
	capabilities = capabilities,
	on_attach = on_attach,
})

require("lspconfig").robotframework_ls.setup({
	cmd = { "robotframework_ls" },
	filetypes = { "robot" },
	capabilities = capabilities,
	on_attach = on_attach,
})

local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
	b.formatting.prettier.with({
		filetypes = { "markdown", "css", "yaml" },
		-- use prettierrc to enable prosewrap:
		-- https://github.com/LazyVim/LazyVim/discussions/2512#discussioncomment-8381919
		-- or just force it for all files:
		-- extra_args = { "--prose-wrap", "always" },
	}),
	b.formatting.shfmt.with({
		filetypes = { "bash", "sh" },
	}),
	b.formatting.stylua,
	b.formatting.sqlfluff,
	b.diagnostics.cfn_lint,
	-- replaced the following with ruff_lsp:
	-- b.formatting.ruff,
	-- b.formatting.ruff_format,
	-- b.diagnostics.ruff,
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = on_attach,
})

M.on_attach = on_attach
M.capabilities = capabilities
return M
