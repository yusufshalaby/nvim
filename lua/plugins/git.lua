return {
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set("n", "<leader>gp", function()
					gs.preview_hunk()
				end, { buffer = bufnr, desc = "Preview git hunk" })
				vim.keymap.set("n", "<leader>gr", function()
					gs.reset_hunk()
				end, { buffer = bufnr, desc = "Reset git hunk" })
				vim.keymap.set("n", "<leader>gt", function()
					gs.preview_hunk_inline()
				end, { buffer = bufnr, desc = "Toggle deleted" })
				vim.keymap.set("n", "<leader>gs", function()
					gs.stage_hunk()
				end, { buffer = bufnr, desc = "Stage hunk" })
				vim.keymap.set("n", "<leader>gb", function()
					gs.blame()
				end, { buffer = bufnr, desc = "Git Blame" })

				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.nav_hunk("next")
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.nav_hunk("prev")
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = function()
			require("diffview").setup({
				-- view = {
				-- 	diff_view = { layout = "diff2_horizontal" },
				-- 	default = { layout = "diff2_horizontal" },
				-- },
				win_config = { type = "split", position = "bottom" },
				default_args = {
					DiffviewOpen = { "--imply-local" },
				},
			})
		end,
	},
}
