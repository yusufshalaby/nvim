local M = {}

M.keys = {
	{
		"<leader>fo",
		mode = { "n" },
		function()
			require("telescope.builtin").oldfiles()
		end,
		desc = "[F]ind recently [o]pened files",
	},
	{
		"<leader>fb",
		mode = { "n" },
		function()
			require("telescope.builtin").buffers()
		end,
		desc = "[F]ind existing [b]uffers",
	},
	{
		"<leader>fz",
		mode = { "n" },
		function()
			require("telescope.builtin").current_buffer_fuzzy_find()
		end,
		desc = "[F]u[z]zily search in current buffer",
	},
	{
		"<leader>fg",
		mode = { "n" },
		function()
			require("telescope.builtin").git_files()
		end,
		desc = "[F]ind [G]it files",
	},
	{
		"<leader>fa",
		mode = { "n" },
		function()
			require("telescope.builtin").find_files({
				find_command = {
					"fd",
					"--type",
					"f",
					"--color",
					"never",
					"--hidden",
					"--no-ignore",
					"--exclude",
					".git",
					"--exclude",
					"venv",
					"--exclude",
					"build",
				},
			})
		end,
		desc = "[F]ind [A]ll files",
	},
	{
		"<leader>ff",
		mode = { "n" },
		function()
			require("telescope.builtin").find_files({
				find_command = {
					"fd",
					"--type",
					"f",
					"--color",
					"never",
					"--hidden",
					"--exclude",
					".git",
				},
			})
		end,
		desc = "[F]ind [F]iles",
	},
	{
		"<leader>fw",
		mode = { "n" },
		function()
			require("telescope.builtin").live_grep()
		end,
		desc = "[F]ind [W]ord",
	},
	{
		"<leader>fd",
		mode = { "n" },
		function()
			require("telescope.builtin").diagnostics()
		end,
		desc = "[F]ind [D]iagnostics",
	},
	{
		"<leader>fr",
		mode = { "n" },
		function()
			require("telescope.builtin").resume()
		end,
		desc = "[F]ind [R]esume",
	},
	{
		"<leader>fh",
		mode = { "n" },
		function()
			require("telescope.builtin").help_tags()
		end,
		desc = "[F]ind [H]elp",
	},
	{
		"<leader>fc",
		mode = { "n" },
		function()
			require("telescope.builtin").git_status()
		end,
		desc = "[F]ind git changes in the project",
	},
}

M.config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-u>"] = false,
					["<C-d>"] = false,
				},
			},
			layout_strategy = "horizontal",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
		},
	})
	pcall(require("telescope").load_extension, "fzf")
end

return M
