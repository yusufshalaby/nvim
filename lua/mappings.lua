local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General
map('n', '<C-s>', '<Cmd>w<CR>', opts)
map('n', '<C-h>', '<C-w>h', { unpack(opts), desc = "Window left" })
map('n', '<C-l>', '<C-w>l', { unpack(opts), desc = "Window right" })
map('n', '<C-j>', '<C-w>j', { unpack(opts), desc = "Window down" })
map('n', '<C-k>', '<C-w>k', { unpack(opts), desc = "Window up" })
map('n', '<Esc>', '<Cmd>noh<CR>', { unpack(opts), desc = "Clear highlights" })

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
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
map('n', '<leader>b', '<Cmd>enew<CR>', { unpack(opts), desc = "New buffer" })
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

-- NvimTree
map('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)

-- telescope
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fx', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fz', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })

-- Comment
vim.keymap.set('n', '<leader>/', function()
  require("Comment.api").toggle.linewise.current()
end, { desc = 'Comment line' })
