return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			{
				"nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-treesitter/nvim-treesitter",
				"nvim-neotest/neotest-python",
				"rouge8/neotest-rust",
				{ "fredrikaverpil/neotest-golang", version = "*" },
			},
		},
		config = function()
			--- @diagnostic disable: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						-- dap = { justMyCode = false },
						-- runner = "pytest",
						-- python = "venv/bin/python",
					}),
					require("neotest-rust"),
					require("neotest-golang")({ testify_enabled = true }),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
				-- quickfix = {
				-- 	open = function()
				-- 		vim.cmd("copen")
				-- 	end,
				-- },
			})
			-- require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.loop.cwd())
				end,
				desc = "Run All Test Files",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run Nearest",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle Summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show Output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop",
			},
		},
	},
	{
		"vim-test/vim-test",
		cmd = {
			"TestNearest",
			"TestClass",
			"TestFile",
			"TestSuite",
			"TestLast",
			"TestVisit",
		},
		config = function()
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#term_position"] = "vert botright"
		end,
	},
}
