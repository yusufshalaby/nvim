local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General
map('n', '<C-s>', '<Cmd>w<CR>', opts)
map('n', '<C-h>', '<C-w>h', { unpack(opts), desc = "Window left" })
map('n', '<C-l>', '<C-w>l', { unpack(opts), desc = "Window right" })
map('n', '<C-j>', '<C-w>j', { unpack(opts), desc = "Window down" })
map('n', '<C-k>', '<C-w>k', { unpack(opts), desc = "Window up" })
map('n', '<Esc>', '<Cmd>noh<CR>', { unpack(opts), desc = "Clear highlights" })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffers
map('n', '<tab>', '<Cmd>BufferNext<CR>', opts)
map('n', '<S-tab>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-h>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferMoveNext<CR>', opts)
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>b', '<Cmd>enew<CR>', { unpack(opts), desc = "New buffer" })
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

-- NvimTree
map('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)

-- telescope
vim.keymap.set('n', '<leader>fo', "<CMD> Telescope oldfiles <CR>", { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fx', "<CMD> Telescope buffers <CR>", { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fz', "<CMD> Telescope current_buffer_fuzzy_find <CR>", { desc = 'Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>fg', "<CMD> Telescope git_files <CR>", { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', "<CMD> Telescope find_files <CR>", { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fw', "<CMD> Telescope live_grep <CR>", { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', "<CMD> Telescope diagnostics <CR>", { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', "<CMD> Telescope resume <CR>", { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>fh', "<CMD> Telescope help_tags <CR>", { desc = '[S]earch [H]elp' })

-- Comment
vim.keymap.set('n', '<leader>/', function()
  require("Comment.api").toggle.linewise.current()
end, { desc = 'Comment line' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>fl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
