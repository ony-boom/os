vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

local to_be_highlighted = {
	"typescript",
	"javascript",
	"tsx",
	"svelte",
	"go",
	"nix",
	"markdown",
	"json",
	"css",
	"html",
	"toml",
	"lua",
}

local tree_sitter = require("nvim-treesitter")

tree_sitter.install(to_be_highlighted)

vim.api.nvim_create_autocmd("FileType", {
	pattern = to_be_highlighted,
	callback = function()
		vim.treesitter.start()
	end,
})
