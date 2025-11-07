vim.pack.add({ "stevearc/conform.nvim" })

local web = { "prettierd", "prettier", stop_after_first = true }

-- Limit biome detection to current working directory
local cwd = vim.loop.cwd() or vim.fn.getcwd()
local biome_root = vim.fs.root(cwd, { "biome.json", "biome.jsonc" })

if biome_root then
	table.insert(web, 1, "biome")
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		go = { "gofumpt", "goimports" },
		json = web,
		jsonc = web,
		javascript = web,
		typescript = web,
		javascriptreact = web,
		typescriptreact = web,
		html = web,
		css = web,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})
