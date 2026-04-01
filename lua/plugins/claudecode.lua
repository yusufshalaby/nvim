return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal = {
			provider = "none", -- no UI actions; server + tools remain available
		},
		diff_opts = {
			auto_close_on_accept = true,
			vertical_split = true,
			open_in_current_tab = false,
			keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens (including floating terminals)
		},
	},
	lazy = false,
	keys = {
		{ "<leader>a",  nil,                        desc = "AI/Claude Code" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>",  mode = "v",                 desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		-- Diff management
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
	},
}
