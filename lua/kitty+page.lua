-- https://github.com/kovidgoyal/kitty/issues/719#issuecomment-1721699211
local setup = function()
	local nlines = vim.fn.getenv("INPUT_LINE_NUMBER")
	local cur_line = vim.fn.getenv("CURSOR_LINE")
	local cur_column = vim.fn.getenv("CURSOR_COLUMN")
	vim.opt.encoding = "utf-8"
	vim.opt.clipboard = "unnamed"
	vim.opt.compatible = false
	vim.opt.number = false
	vim.opt.relativenumber = false
	vim.opt.termguicolors = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.opt.showmode = true
	vim.opt.ruler = false
	vim.opt.laststatus = 0
	vim.opt.showcmd = false
	vim.opt.scrollback = 1000
	-- use the visual color matching the current colorscheme
	vim.cmd("hi Visual ctermbg=237 guibg=#45403d")
	vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")
	local term_buf = vim.api.nvim_create_buf(true, false)
	local term_io = vim.api.nvim_open_term(term_buf, {})
	vim.api.nvim_buf_set_keymap(term_buf, "n", "q", "<Cmd>q<CR>", {})
	local group = vim.api.nvim_create_augroup("kitty+page", {})

	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		pattern = "*",
		once = true,
		callback = function(ev)
			local current_win = vim.fn.win_getid()
			for _, line in ipairs(vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)) do
				vim.api.nvim_chan_send(term_io, line)
				vim.api.nvim_chan_send(term_io, "\r\n")
			end
			-- term_io = false
			vim.api.nvim_create_autocmd("ModeChanged", {
				group = group,
				pattern = "([nN]:[^vV])|([vV]:[^nN])",
				command = "stopinsert",
			})
			vim.api.nvim_win_set_buf(current_win, term_buf)
			if nlines ~= vim.NIL and cur_line ~= vim.NIL and cur_column ~= vim.NIL then
				vim.api.nvim_win_set_cursor(current_win, { vim.fn.max({ 1, nlines }) + cur_line, cur_column - 1 })
			else
				vim.api.nvim_input([[<C-\><C-n>G]])
			end
			vim.api.nvim_buf_delete(ev.buf, { force = true })
		end,
	})
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
end
setup()
