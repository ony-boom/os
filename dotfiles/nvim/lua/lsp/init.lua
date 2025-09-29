vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local servers = require("lsp.servers")

vim.lsp.enable(servers)

require("lsp.configs")
require("lsp.mappings")
require("lsp.completions")
