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
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = require("plugins.lsp.on_attach"),
})
