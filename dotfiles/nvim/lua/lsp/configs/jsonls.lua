vim.pack.add({ "https://github.com/b0o/schemastore.nvim" })

vim.lsp.config("jsonls", {
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	},

	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
