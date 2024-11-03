return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>fo",
			mode = { "n" },
			function()
				-- this is broken in the current version of telescope for folders with special characters
				-- I ran into this issue inside my obsidian icloud folder
				-- the fix has been merged but it's not been released yet
				-- https://github.com/nvim-telescope/telescope.nvim/issues/2857#issue-2074014634
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind recently [o]pened files",
		},
		{
			"<leader>fb",
			mode = { "n" },
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[F]ind existing [b]uffers",
		},
		{
			"<leader>fz",
			mode = { "n" },
			function()
				require("fzf-lua").grep_curbuf()
			end,
			desc = "[F]u[z]zily search in current buffer",
		},
		{
			"<leader>fg",
			mode = { "n" },
			function()
				require("fzf-lua").git_files()
			end,
			desc = "[F]ind [G]it files",
		},
		{
			"<leader>ff",
			mode = { "n" },
			function()
				require("fzf-lua").files()
			end,
			desc = "[F]ind [F]iles",
		},
		{
			"<leader>fw",
			mode = { "n" },
			function()
				require("fzf-lua").live_grep_native()
			end,
			desc = "[F]ind [W]ord",
		},
		{
			"<leader>fd",
			mode = { "n" },
			function()
				require("fzf-lua").diagnostics_workspace()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>fr",
			mode = { "n" },
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>fh",
			mode = { "n" },
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fc",
			mode = { "n" },
			function()
				require("fzf-lua").git_status()
			end,
			desc = "[F]ind git changes in the project",
		},
		{
			"<leader>fs",
			mode = { "n" },
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind [s]tring beneath the cursor",
		},
		{
			"<leader>ws",
			mode = { "n" },
			function()
				require("fzf-lua").lsp_live_workspace_symbols()
			end,
			"[W]orkspace [S]ymbols",
		},
	},
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({ "fzf-native", fzf_colors = true })
	end,
}
