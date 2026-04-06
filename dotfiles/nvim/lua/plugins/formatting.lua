vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local web = { "prettierd", "prettier", stop_after_first = true }
local with_oxc = table.insert(web, 1, "oxfmt")

-- Limit biome detection to current working directory
local cwd = vim.loop.cwd() or vim.fn.getcwd()
local biome_root = vim.fs.root(cwd, { "biome.json", "biome.jsonc" })
local deno_root = vim.fs.root(cwd, { "deno.json", "deno.jsonc" })

if deno_root then
	table.insert(web, 1, "deno_fmt")
end

if biome_root then
	table.insert(web, 1, "biome")
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		go = { "gofumpt", "goimports" },
		json = with_oxc,
		jsonc = with_oxc,
		javascript = with_oxc,
		typescript = with_oxc,
		javascriptreact = with_oxc,
		typescriptreact = with_oxc,
		html = with_oxc,
		css = with_oxc,
		markdown = with_oxc,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})
