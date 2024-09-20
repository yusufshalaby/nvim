return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	require "plugins.debug",
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
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
		"mfussenegger/nvim-lint",
		lazy = true,
		ft = { "python", "robot" },
		config = function()
			require("lint").linters_by_ft = {
				python = { "ruff" },
				robot = { "robocop" },
			}
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = true,
					})
				end,
				{ desc = "Format buffer" },
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "ruff_fix", "ruff_format" },
				},
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		-- version = "^3", -- Recommended
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
				tools = {
					float_win_config = {
						border = "double",
					},
				},
			}
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = require("plugins.lspconfig").on_attach
			metals_config.capabilities = require("plugins.lspconfig").capabilities
			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
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
		enabled = false,
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
		keys = {
			{
				"<leader>d",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Toggle diagnostics",
			},
			{
				"<leader>q",
				"<cmd>Trouble quickfix toggle<cr>",
				desc = "Toggle diagnostics",
			},
			{
				"<leader>l",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Toggle diagnostics",
			},
		},
		-- opts = {},
		config = function()
			require("trouble").setup({})
			vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
			vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "Normal" })
		end,
	},
	{
		"goolord/alpha-nvim",
		enabled = false,
		config = function()
			require("alpha").setup(require("plugins.alpha").config)
		end,
	},
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "neovim"
		end,
		config = function()
			vim.g.slime_input_pid = false
			vim.g.slime_suggest_default = true
			vim.g.slime_menu_config = false
			vim.g.slime_neovim_ignore_unlisted = false
			vim.api.nvim_command([[
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

				let g:slime_config_defaults["scala_ammonite"] = 0
				function! _EscapeText_scala(text)
				  if slime#config#resolve("scala_ammonite")
				    return ["{\n", a:text, "}\n"]
				  end
				  " \x04 is ctrl-d
				  return [":paste\n", a:text, "\x04"]
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
		enabled = false,
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
			vim.cmd("colorscheme carbonfox")
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
		enabled = true,
		config = function()
			require("plugins.kanagawa")
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("moonfly")
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
		end,
		-- config = function()
		-- 	vim.cmd("colorscheme tokyonight")
		-- end,
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
		"norcalli/nvim-colorizer.lua",
		cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		config = function()
			require("diffview").setup({
				view = {
					diff_view = { layout = "diff2_vertical" },
					default = { layout = "diff2_vertical" },
				},
				win_config = { type = "split", position = "bottom" },
				default_args = {
					DiffviewOpen = { "--imply-local" },
				},
			})
		end,
	},
}
