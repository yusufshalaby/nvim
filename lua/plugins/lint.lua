return {
	"mfussenegger/nvim-lint",
	lazy = true,
	ft = { "python", "robot", "sql" },
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff" },
			robot = { "robocop" },
			sql = { "sqlfluff" },
		}
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
}
