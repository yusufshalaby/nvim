---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- virtual text for debugger
		"theHamsta/nvim-dap-virtual-text",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
	},
	-- stylua: ignore
	keys = {
		{ "<leader>d",  "",                                                                                   desc = "+debug", mode = { "n", "v" } },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
		{ "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
		{ "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
		{ "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
		{ "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
		{ "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
		{ "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
		{ "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
		{ "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
		{ "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
		{ "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
		{ "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
		{ "<leader>du", function() require("dapui").toggle() end,                                              desc = "UI" },
		{ "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
		{ "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},

			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.5,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						-- {
						-- 	id = "watches",
						-- 	size = 0.25,
						-- },
					},
					position = "left",
					size = 40,
				},
				-- {
				-- 	elements = {
				-- 		{
				-- 			id = "repl",
				-- 			size = 0.5,
				-- 		},
				-- 		{
				-- 			id = "console",
				-- 			size = 0.5,
				-- 		},
				-- 	},
				-- 	position = "bottom",
				-- 	size = 10,
				-- },
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
				type = "server",
				port = 38697,
			},
			dap_configurations = {
				{
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
		})
	end,
}
