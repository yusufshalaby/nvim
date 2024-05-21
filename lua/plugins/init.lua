return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvimtools/none-ls.nvim",
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lspconfig")
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = require("plugins.lspconfig").on_attach,
					capabilities = require("plugins.lspconfig").capabilities,
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
						},
					},
				},
			}
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			require("plugins.neotest").dependencies,
		},
		config = require("plugins.neotest").config,
		keys = require("plugins.neotest").keys,
	},
	{
		"ThePrimeagen/harpoon",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function()
			require("plugins.harpoon")
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = require("plugins.nvim-cmp").dependencies,
		config = require("plugins.nvim-cmp").config,
	},
	{ "folke/which-key.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim", opts = require("plugins.gitsigns") },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = require("plugins.telescope").keys,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = require("plugins.telescope").config,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.defer_fn(function()
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup(require("plugins.nvim-treesitter"))
			end, 0)
		end,
	},
	{
		"numToStr/Comment.nvim",
		enabled = false,
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
			{
				"<leader>/",
				mode = { "n", "v" },
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				desc = "Comment toggle current line",
			},
		},
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = require("plugins.lualine"),
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = { suggestion = { auto_trigger = true } },
		config = function()
			require("plugins.copilot")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false,
				},
			},
		},
		-- stylua: ignore
		keys = require("plugins.flash").keys,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				-- ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
		config = function()
			vim.keymap.set("n", "[p", function()
				require("treesitter-context").go_to_context()
			end, { silent = true, desc = "Go to previous context" })
			vim.keymap.set("n", "<leader>tc", "<CMD>TSContextToggle<CR>", { desc = "Toggle treesitter context" })
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("plugins.alpha").config)
		end,
	},
	{
		"jpalardy/vim-slime",
		config = function()
			vim.api.nvim_command([[
				if exists('$TMUX')
				  let g:slime_target = 'tmux'
				  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
				elseif $TERM_PROGRAM == 'WezTerm'
				  let g:slime_target = 'wezterm'
				  let g:slime_default_config = {"pane_direction": "right"}
				elseif $TERM == 'xterm-kitty'
				  let g:slime_target = 'kitty'
				endif

				let g:slime_bracketed_paste =1
				let g:slime_config_defaults["python_ipython"] = 0
				let g:slime_config_defaults["dispatch_ipython_pause"] = 100

				function! _EscapeText_python(text)
				  if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
				    return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
				  else
				    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
				    let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
				    let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
				    let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
				    let except_pat = '\(elif\|else\|except\|finally\)\@!'
				    let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
				    return substitute(dedented_lines, add_eol_pat, "\n", "g")
				  end
				endfunction
				]])
		end,
	},
	{
		"stevearc/oil.nvim",
		keys = {
			{
				"<C-n>",
				function()
					require("oil").toggle_float()
				end,
				{ desc = "Open oil" },
			},
			{
				"-",
				function()
					require("oil").open()
				end,
				{ desc = "Open oil" },
			},
		},
		event = { "Syntax" },
		opts = {
			use_default_keymaps = false,
			keymaps = {
				["-"] = "actions.parent",
				["<C-n>"] = "actions.close",
				["<CR>"] = "actions.select",
				["H"] = "actions.toggle_hidden",
				["g?"] = "actions.show_help",
				["gx"] = "actions.open_external",
			},
			columns = {
				"icon",
				-- "permissions",
				"size",
				-- "mtime",
			},
			view_options = {
				show_hidden = true,
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<CMD>UndotreeToggle<CR>", { desc = "Toggle undotree" } },
		},
	},
	{
		"sainnhe/gruvbox-material",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("let g:gruvbox_material_background = 'medium'")
			vim.cmd("let g:gruvbox_material_foreground = 'material'")
			vim.cmd("let g:gruvbox_material_better_performance = 1")
			vim.cmd("let g:gruvbox_material_float_style = 'dim'")
			vim.cmd("colorscheme gruvbox-material")
			vim.cmd("hi CursorLineNr guifg=#d8a657")
			vim.cmd("hi @markup.italic.markdown_inline cterm=italic gui=italic")
		end,
	},
	{
		"sainnhe/everforest",
		enabled = true,
		config = function()
			vim.cmd("let g:everforest_background = 'medium'")
			vim.cmd("let g:everforest_better_performance = 1")
			vim.cmd("let g:everforest_float_style = 'dim'")
			vim.cmd("colorscheme everforest")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
		config = function()
			require("plugins.catppuccin")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		config = function()
			vim.cmd("colorscheme nordfox")
			vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "rainbowcol1" })
			vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "rainbowcol2" })
			vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "rainbowcol3" })
			vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "rainbowcol4" })
			vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { link = "rainbowcol5" })
			vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { link = "rainbowcol6" })
			vim.cmd("hi @markup.italic.markdown_inline cterm=italic gui=italic")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		config = function()
			require("plugins.kanagawa")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.tokyonight")
			vim.cmd("colorscheme tokyonight")
			vim.cmd("hi CursorLineNr guifg=#ffc777")
			vim.cmd("hi @markup.italic.markdown_inline cterm=italic gui=italic")
		end,
		-- config = function()
		-- 	vim.cmd("colorscheme tokyonight")
		-- end,
	},
	{
		"tamton-aquib/duck.nvim",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		keys = {
			{ "<leader>on", "<CMD>ObsidianNew<CR>", { desc = "Obsidian new" } },
			{ "<leader>ot", "<CMD>ObsidianToday<CR>", { desc = "Obsidian today" } },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = require("plugins.obsidian"),
	},
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		opts = require("plugins.zen-mode"),
	},
	{
		"ellisonleao/carbon-now.nvim",
		lazy = true,
		cmd = "CarbonNow",
		opts = require("plugins.carbon-now"),
	},
	{
		"cameron-wags/rainbow_csv.nvim",
		enabled = true,
		config = function()
			require("rainbow_csv").setup()
			vim.cmd(
				"let g:rcsv_colorlinks = ['Blue','Yellow','Aqua','Orange','Green','Red','Purple','Blue','Yellow','Aqua']"
			)
		end,
		ft = "csv",
	},
	{
		"chrishrb/gx.nvim",
		enabled = false,
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
}
