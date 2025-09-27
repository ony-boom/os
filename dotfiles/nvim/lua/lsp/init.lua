vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")

require("lsp.mappings")
