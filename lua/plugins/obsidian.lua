return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	cmd = { "Obsidian" },
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see above for full list of optional dependencies ☝️
	},
	---@module 'obsidian'
	---@type obsidian.config.ClientOpts
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "/Users/yusufshalaby/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes",
			},
		},
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "dailies",
		},
		ui = { enable = false },
		completion = {
			-- Enables completion using nvim_cmp
			nvim_cmp = false,
			-- Enables completion using blink.cmp
			blink = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},

		-- see below for full list of options 👇
	},
}
