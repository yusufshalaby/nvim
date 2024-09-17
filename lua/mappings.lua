local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General
map("n", "<C-s>", "<Cmd>w<CR>", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "Q", "<nop>", opts)
map("n", "<C-h>", "<C-w>h", { unpack(opts), desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { unpack(opts), desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { unpack(opts), desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { unpack(opts), desc = "Window up" })
map("n", "<Esc>", "<Cmd>noh<CR>", { unpack(opts), desc = "Clear highlights" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader><leader>", ":", { noremap = true, desc = "Command prompt" })

-- Buffers
map("n", "<tab>", "<Cmd>bn<CR>", opts)
map("n", "<S-tab>", "<Cmd>bp<CR>", opts)
map("n", "<leader>b", "<Cmd>enew<CR>", { unpack(opts), desc = "New buffer" })
map("n", "<leader>x", "<Cmd>bd<CR>", { unpack(opts), desc = "Delete buffer" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>fl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Quickfix keymaps
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "[q", "<Cmd>cprev<CR>", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "[Q", "<Cmd>cfirst<CR>", { desc = "Go to first quickfix item" })
vim.keymap.set("n", "]Q", "<Cmd>clast<CR>", { desc = "Go to last quickfix item" })
vim.keymap.set("n", "]l", "<Cmd>lnext<CR>", { desc = "Go to next location list item" })
vim.keymap.set("n", "[l", "<Cmd>lprev<CR>", { desc = "Go to previous location list item" })
vim.keymap.set("n", "[L", "<Cmd>lfirst<CR>", { desc = "Go to first location list item" })
vim.keymap.set("n", "]L", "<Cmd>llast<CR>", { desc = "Go to last location list item" })

-- Treesitter Context
vim.keymap.set("n", "<leader>tc", "<CMD>TSContextEnable<CR>", { desc = "Enable treesitter context" })

-- JQ
function FormatJson()
	local file_extension = vim.fn.expand("%:e")
	if file_extension == "json" then
		vim.cmd([[silent! %!jq .]])
	else
		print("This command is only available for JSON files.")
	end
end

vim.keymap.set("n", "<leader>jq", "<CMD>call v:lua.FormatJson()<CR>", { desc = "Format JSON" })

-- Treesitter folds
function TreesitterFolds()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

vim.keymap.set("n", "<leader>tf", "<CMD>call v:lua.TreesitterFolds()<CR>", { desc = "Enable treesitter folds" })
