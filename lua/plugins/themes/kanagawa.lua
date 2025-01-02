return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			compile = true, -- enable compiling the colorscheme
			undercurl = false, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = { ui = { bg_gutter = "none" } } },
			},
			-- overrides = function(colors) -- add/modify highlights
			-- 	return {
			-- 		-- Assign a static color to strings
			-- 		CursorLineNr = { fg = colors.palette.carpYellow, italic = false },
			-- 	}
			-- end,
			theme = "dragon", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				light = "lotus",
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },

					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					Red = { fg = colors.palette.autumnRed },
					Yellow = { fg = colors.palette.carpYellow },
					Blue = { fg = colors.palette.dragonBlue },
					Orange = { fg = colors.palette.surimiOrange },
					Green = { fg = colors.palette.springGreen },
					Purple = { fg = colors.palette.oniViolet },
					Aqua = { fg = colors.palette.waveAqua1 },
					["@markup.heading.1.markdown"] = { link = "Red" },
					["@markup.heading.2.markdown"] = { link = "Yellow" },
					["@markup.heading.3.markdown"] = { link = "Blue" },
					["@markup.heading.4.markdown"] = { link = "Orange" },
					["@markup.heading.5.markdown"] = { link = "Green" },
					["@markup.heading.6.markdown"] = { link = "Purple" },
					["@markup.heading.7.markdown"] = { link = "Aqua" },
					-- FloatBorder = { fg = colors.palette.carpYellow, bg = theme.ui.bg },
					-- NormalFloat = { bg = theme.ui.bg },

					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
