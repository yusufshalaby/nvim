local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General
map('n', '<C-s>', '<Cmd>w<CR>', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', 'Q', '<nop>', opts)
map('n', '<C-h>', '<C-w>h', { unpack(opts), desc = "Window left" })
map('n', '<C-l>', '<C-w>l', { unpack(opts), desc = "Window right" })
map('n', '<C-j>', '<C-w>j', { unpack(opts), desc = "Window down" })
map('n', '<C-k>', '<C-w>k', { unpack(opts), desc = "Window up" })
map('n', '<Esc>', '<Cmd>noh<CR>', { unpack(opts), desc = "Clear highlights" })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffers
map("n", "<tab>", "<Cmd>bn<CR>", opts)
map("n", "<S-tab>", "<Cmd>bp<CR>", opts)
map('n', '<leader>b', '<Cmd>enew<CR>', { unpack(opts), desc = "New buffer" })
map('n', '<leader>x', '<Cmd>bd<CR>', { unpack(opts), desc = "Delete buffer" })

-- NvimTree
map('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)

-- telescope
vim.keymap.set('n', '<leader>fo', "<CMD> Telescope oldfiles <CR>", { desc = '[F]ind recently [o]pened files' })
vim.keymap.set('n', '<leader>fx', "<CMD> Telescope buffers <CR>", { desc = '[F]ind e[x]xisting buffers' })
vim.keymap.set('n', '<leader>fz', "<CMD> Telescope current_buffer_fuzzy_find <CR>", { desc = '[F]u[z]zily search in current buffer' })
vim.keymap.set('n', '<leader>fg', "<CMD> Telescope git_files <CR>", { desc = '[F]ind [G]it files' })
vim.keymap.set('n', '<leader>ff', "<CMD> Telescope find_files <CR>", { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fw', "<CMD> Telescope live_grep <CR>", { desc = '[F]ind [W]ord' })
vim.keymap.set('n', '<leader>fd', "<CMD> Telescope diagnostics <CR>", { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', "<CMD> Telescope resume <CR>", { desc = '[F]ind [R]esume' })
vim.keymap.set('n', '<leader>fh', "<CMD> Telescope help_tags <CR>", { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>cb', "<CMD> Telescope git_bcommits <CR>", { desc = 'Git [C]ommits [B]uffer' })
vim.keymap.set('n', '<leader>gbr', "<CMD> Telescope git_branches <CR>", { desc = '[G]it [BR]anches' })

-- Comment
vim.keymap.set('n', '<leader>/', function()
  require("Comment.api").toggle.linewise.current()
end, { desc = 'Comment line' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>fl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
