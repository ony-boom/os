vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local prettiers = { "biome", "prettier", stop_after_first = true }

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		go = { "gofumpt", "goimports" },
		javascript = prettiers,
		typescript = prettiers,
		javascriptreact = prettiers,
		typescriptreact = prettiers,
		html = prettiers,
		css = prettiers,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})
