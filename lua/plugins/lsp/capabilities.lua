-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
return require("cmp_nvim_lsp").default_capabilities(capabilities)
