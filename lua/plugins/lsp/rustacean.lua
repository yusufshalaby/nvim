return {
	"mrcjkb/rustaceanvim",
	-- version = "^3", -- Recommended
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = require("plugins.lsp.on_attach"),
				capabilities = require("plugins.lsp.capabilities"),
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
}
