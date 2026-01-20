vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	"https://github.com/esmuellert/nvim-eslint",
})

local servers = require("lsp.servers")

vim.lsp.enable(servers)

require("lsp.configs")
require("lsp.mappings")
require("lsp.completions")
require("nvim-eslint").setup({})
