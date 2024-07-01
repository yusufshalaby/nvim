vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.scrolloff = 8
vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 50
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.wo.relativenumber = true
vim.diagnostic.config({
	float = {
		border = "rounded",
	},
})

-- for vim-rhubarb to open browser
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "open", opts.fargs[1] })
end, { nargs = 1 })

require("mappings")
require("lazy").setup({ require("plugins") }, { ui = { border = "rounded", backdrop = 100 } })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- local markdown_enter_group = vim.api.nvim_create_augroup("MarkdownEnterBuffer", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function()
-- 		vim.opt.conceallevel = 2
-- 	end,
-- 	group = markdown_enter_group,
-- 	pattern = "*.md",
-- })
--
-- local markdown_leave_group = vim.api.nvim_create_augroup("MarkdownLeaveBuffer", { clear = true })
-- vim.api.nvim_create_autocmd("BufLeave", {
--   callback = function()
--     vim.opt.conceallevel = 0
--   end,
--   group = markdown_leave_group,
--   pattern = "*.md",
-- })

-- for neovide
vim.opt.guifont = { "JetBrains Mono", ":h18" }
vim.g.neovide_input_macos_option_key_is_meta = "both"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
