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
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format" },
				markdown = { "prettier" },
				css = { "prettier" },
				yaml = { "prettier" },
				toml = { "taplo" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				lua = { "stylua" },
			},
		})
	end,
}
