local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map(
	"n",
	"<leader>h",
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
	{ unpack(opts), desc = "Toggle Harpoon menu" }
)
map("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", { unpack(opts), desc = "Add file to Harpoon" })

map("n", "<tab>", "<Cmd> lua require('harpoon.ui').nav_next()<CR>", opts)
map("n", "<S-tab>", "<Cmd> lua require('harpoon.ui').nav_prev()<CR>", opts)
map("n", "<A-1>", "<Cmd> lua require('harpoon.ui').nav_file(1)<CR>", opts)
map("n", "<A-2>", "<Cmd> lua require('harpoon.ui').nav_file(2)<CR>", opts)
map("n", "<A-3>", "<Cmd> lua require('harpoon.ui').nav_file(3)<CR>", opts)
map("n", "<A-4>", "<Cmd> lua require('harpoon.ui').nav_file(4)<CR>", opts)
map("n", "<A-5>", "<Cmd> lua require('harpoon.ui').nav_file(5)<CR>", opts)
map("n", "<A-6>", "<Cmd> lua require('harpoon.ui').nav_file(6)<CR>", opts)
map("n", "<A-7>", "<Cmd> lua require('harpoon.ui').nav_file(7)<CR>", opts)
map("n", "<A-8>", "<Cmd> lua require('harpoon.ui').nav_file(8)<CR>", opts)
map("n", "<A-9>", "<Cmd> lua require('harpoon.ui').nav_file(9)<CR>", opts)
