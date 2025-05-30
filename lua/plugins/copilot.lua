return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				auto_refresh = false,
				keymap = {
					accept = "<CR>",
					jump_prev = "[[",
					jump_next = "]]",
					refresh = "gr",
					open = "<M-CR>",
				},
			},
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<M-l>",
					prev = "<M-[>",
					next = "<M-]>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				["*"] = true,
			},
			server_opts_overrides = { settings = { telemetry = { telemetryLevel = "off" } } },
		})
	end,
}
