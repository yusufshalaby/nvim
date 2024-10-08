return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>ds", "<cmd>Trouble toggle symbols<cr>", desc = "Symbols (Trouble)" },
		{ "gr", "<cmd>Trouble toggle lsp_references<cr>", desc = "LSP references (Trouble)" },
		{ "gI", "<cmd>Trouble toggle lsp_implementations<cr>", desc = "LSP references (Trouble)" },
		{
			"<leader>D",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Toggle diagnostics",
		},
		{
			"<leader>Q",
			"<cmd>Trouble quickfix toggle<cr>",
			desc = "Toggle diagnostics",
		},
		{
			"<leader>L",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Toggle diagnostics",
		},
	},
	-- opts = {},
	config = function()
		require("trouble").setup({})
		vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "Normal" })

		-- Replace the quickfix window with Trouble when viewing TSC results
		local function replace_quickfix_with_trouble()
			local title = vim.fn.getqflist({ title = 0 }).title
			if title ~= "Git --no-literal-pathspecs difftool" then
				return
			end

			local ok, trouble = pcall(require, "trouble")
			if ok then
				vim.defer_fn(function()
					vim.cmd("cclose")
					trouble.open("quickfix")
				end, 0)
			end
		end

		local group = vim.api.nvim_create_augroup("ReplaceQuickfixWithTrouble", {})
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "quickfix",
			group = group,
			callback = replace_quickfix_with_trouble,
		})
	end,
}
