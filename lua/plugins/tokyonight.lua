---@diagnostic disable: inject-field
require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = false },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		-- sidebars = "dark", -- style for sidebars, see below
		-- floats = "dark",   -- style for floating windows
	},
	-- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3,      -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false,      -- dims inactive windows
	lualine_bold = false,      -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors)
		colors.bg = "#232323"
		colors.bg_sidebar = "#161616"
		colors.bg_float = "#232323"
		colors.bg_popup = "#161616"
		colors.comment = "#6e78a4"
		colors.fg_gutter = "#454d71"

	end,

	--- You can override specific highlights to use other groups or a hex color
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors)
		highlights["@markup.raw.markdown_inline"] = {
			bg = colors.bg,
			fg = colors.blue,
			style = "italic",
		}
		highlights.GitSignsAdd = { fg = colors.green }
		highlights.GitSignsChange = { fg = colors.yellow }
		highlights.GitSignsDelete = { fg = colors.red }
		highlights.StatusLine = { bg = colors.bg_statusline }
		highlights.Pmenu = { bg = colors.bg }
	end,
})
