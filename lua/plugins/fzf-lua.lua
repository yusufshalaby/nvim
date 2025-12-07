return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>fo",
			mode = { "n" },
			function()
				require("fzf-lua").oldfiles({ include_current_session = true, cwd_only = true })
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
				require("fzf-lua").files({ cwd_prompt = false })
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
				require("fzf-lua").files({
					cwd_prompt = false,
					fd_opts = [[--color=never --hidden --type d --exclude .git]],
					previewer = false,
					winopts = { title = "Directories " },
				})
			end,
			desc = "[F]ind [D]iriectories",
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
			"<leader>fq",
			mode = { "n" },
			function()
				require("fzf-lua").quickfix()
			end,
			desc = "[F]ind [Q]uickfix",
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
		require("fzf-lua").setup({
			"fzf-native",
			fzf_colors = true,
			winopts = {
				preview = {
					hidden = true
				}
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
					["ctrl-z"] = "toggle-preview"
				}
			},
		})
	end,
}
