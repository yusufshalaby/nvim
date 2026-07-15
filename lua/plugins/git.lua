return {
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- Skip fugitive buffers to prevent bad repo cache when using git worktrees.
			-- When :Git opens, fugitive creates a buffer like "fugitive://.../worktrees/name//".
			-- Gitsigns tries to attach, parses that path, and caches a broken repo config.
			-- Unlike normal .git directories, worktree metadata dirs (.bare/worktrees/X/)
			-- aren't self-contained and need --work-tree context, which gitsigns doesn't provide.
			-- Not calling the callback skips attachment entirely for these buffers.
			_on_attach_pre = function(bufnr, callback)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("^fugitive://") then
					return -- Don't call callback, skip this buffer entirely
				end
				callback()
			end,
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
				vim.keymap.set("n", "<leader>gd", function()
					gs.diffthis()
				end, { buffer = bufnr, desc = "Git diff" })
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
		"esmuellert/codediff.nvim",
		cmd = { "CodeDiff", "PR" },
		config = function()
			vim.api.nvim_create_user_command("PR", function()
				vim.cmd("CodeDiff origin/HEAD...HEAD")
			end, {})
			require("codediff").setup(
				{
					-- Diff view behavior
					diff = {
						layout = "inline", -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
						disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
						max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
						ignore_trim_whitespace = false, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
						hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
						original_position = "left", -- Position of original (old) content: "left" or "right"
						conflict_ours_position = "right", -- Position of ours (:2) in conflict view: "left" or "right"
						conflict_result_position = "bottom", -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
						conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
						conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
						cycle_next_hunk = true, -- Wrap around when navigating hunks (]c/[c): false to stop at first/last
						cycle_next_file = true, -- Wrap around when navigating files (]f/[f): false to stop at first/last
						cycle_hunks_across_files = false, -- ]c/[c at file boundary hops to first/last hunk of next/prev file (explorer/history)
						jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
						highlight_priority = 100, -- Priority for line-level diff highlights (increase to override LSP highlights)
						compute_moves = false, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
						compact_context_lines = 3, -- Number of context lines around hunks in compact mode
						compact_sync_folds = true, -- Sync fold open/close across panes (mirrors Vim diff mode behavior)
					},

				})
		end
	}
}
