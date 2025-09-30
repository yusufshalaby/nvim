return {
	"stevearc/conform.nvim",
	lazy = true,
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
			mode = { "n", "v" },
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				css = { "prettier" },
				javascript = { "deno_fmt" },
				javascriptreact = { "deno_fmt" },
				lua = { "stylua" },
				markdown = { "deno_fmt" },
				python = { "ruff_fix", "ruff_format" },
				sh = { "shfmt" },
				-- sql = { "sqlfluff" },
				toml = { "taplo" },
				typescript = { "deno_fmt" },
				typescriptreact = { "deno_fmt" },
				typst = { "typstyle" },
				yaml = { "prettier" },
			},
		})
	end,
}
