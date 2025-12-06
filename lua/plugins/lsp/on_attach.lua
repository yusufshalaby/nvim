return function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "double" })
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "double" })

	nmap("<leader>ds", "<cmd> Trouble toggle symbols max_items=10000<CR>", "[D]ocument [S]ymbols")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end
