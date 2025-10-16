return {
	"mfussenegger/nvim-lint",
	lazy = true,
	ft = { "python", "robot", "sql" },
	config = function()
		local lint = require("lint")

		-- Set linters for specific filetypes
		lint.linters_by_ft = {
			python = { "ruff" },
			robot = { "robocop" },
		}

		-- Conditionally enable sqlfluff if it's in PATH
		if vim.fn.executable("sqlfluff") == 1 then
			lint.linters_by_ft.sql = { "sqlfluff" }
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			callback = function()
				local ft = vim.bo.filetype
				-- Only try linting if there is a linter configured for the current filetype
				if lint.linters_by_ft[ft] then
					lint.try_lint()
				end
			end,
		})
	end,
}
