return {
	-- NOTE: First, some plugins that don't require any configuration
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.

	require("plugins.lsp-config"),
	require("plugins.barbar"),
	require("plugins.nvim-tree"),
	require("plugins.nvim-cmp"),
	require("plugins.which-key"),
	require("plugins.gitsigns"),
	require("plugins.telescope"),
	require("plugins.nvim-treesitter"),
	require("plugins.Comment"),
	require("plugins.indent-blankline"),
	require("plugins.lualine"),
	require("plugins.onedark"),
}
