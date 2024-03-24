return {
	-- See `:help gitsigns.txt`
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		vim.keymap.set("n", "<leader>gp", function()
			require("gitsigns").preview_hunk()
		end, { buffer = bufnr, desc = "Preview git hunk" })
		vim.keymap.set("n", "<leader>gr", function()
			require("gitsigns").reset_hunk()
		end, { buffer = bufnr, desc = "Reset git hunk" })
		vim.keymap.set("n", "<leader>gt", function()
			require("gitsigns").toggle_deleted()
		end, { buffer = bufnr, desc = "Toggle deleted" })
		vim.keymap.set("n", "<leader>gs", function()
			require("gitsigns").stage_hunk()
		end, { buffer = bufnr, desc = "Stage hunk" })

		-- don't override the built-in and fugitive keymaps
		local gs = package.loaded.gitsigns
		vim.keymap.set({ "n", "v" }, "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
		vim.keymap.set({ "n", "v" }, "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
	end,
}
