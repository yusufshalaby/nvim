local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "Q", "<nop>", opts)
map("n", "<Esc>", "<Cmd>noh<CR>", { unpack(opts), desc = "Clear highlights" })
map("t", "<Esc>", "<C-\\><C-n>", { unpack(opts), desc = "Escape terminal mode" })
map("n", "<leader>p", '"0p', { unpack(opts), desc = "Paste from yank register" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader><leader>", ":", { noremap = true, desc = "Command prompt" })
vim.keymap.set("n", "<leader>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { desc = "Toggle inlay hints" })

-- Buffers
map("n", "<tab>", "<Cmd>bn<CR>", opts)
map("n", "<S-tab>", "<Cmd>bp<CR>", opts)
map("n", "<leader>b", "<Cmd>enew<CR>", { unpack(opts), desc = "New buffer" })
map("n", "<leader>x", "<Cmd>bd<CR>", { unpack(opts), desc = "Delete buffer" })


-- Windows 
map("n", "<C-h>", "<C-w>h", { unpack(opts), desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { unpack(opts), desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { unpack(opts), desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { unpack(opts), desc = "Window up" })
map("n", "<C-Right>", "<Cmd>vertical resize +5<CR>", { unpack(opts), desc = "Increase window width" })
map("n", "<C-Left>", "<Cmd>vertical resize -5<CR>", { unpack(opts), desc = "Decrease window width" })
map("n", "<C-Up>", "<Cmd>resize +5<CR>", { unpack(opts), desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -5<CR>", { unpack(opts), desc = "Decrease window height" })

-- Tabs
map("n", "<leader><tab>", "<Cmd>tabnext<CR>", { unpack(opts), desc = "Next tab" })
map("n", "<leader><S-tab>", "<Cmd>tabprevious<CR>", { unpack(opts), desc = "Previous tab" })
map("n", "<leader>X", "<Cmd>tabclose<CR>", { unpack(opts), desc = "Close tab" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>fl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set("n", "[Q", "<Cmd>cfirst<CR>", { desc = "Go to first quickfix item" })
vim.keymap.set("n", "]Q", "<Cmd>clast<CR>", { desc = "Go to last quickfix item" })
vim.keymap.set("n", "]l", "<Cmd>lnext<CR>", { desc = "Go to next location list item" })
vim.keymap.set("n", "[l", "<Cmd>lprev<CR>", { desc = "Go to previous location list item" })
vim.keymap.set("n", "[L", "<Cmd>lfirst<CR>", { desc = "Go to first location list item" })
vim.keymap.set("n", "]L", "<Cmd>llast<CR>", { desc = "Go to last location list item" })
vim.keymap.set(
	"n",
	"<leader>gq",
	"<Cmd>Git difftool | cclose | Trouble quickfix<CR>",
	{ desc = "Send git diff to quickfix" }
)

-- Treesitter Context
vim.keymap.set("n", "<leader>tc", "<CMD>TSContextEnable<CR>", { desc = "Enable treesitter context" })

-- Treesitter folds
function TreesitterFolds()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
end

vim.keymap.set("n", "<leader>tf", function()
	vim.cmd("call v:lua.TreesitterFolds()")
end, { desc = "Enable treesitter folds" })
