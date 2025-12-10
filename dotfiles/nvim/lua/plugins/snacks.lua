vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	input = { enabled = true },
	words = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			explorer = {
				replace_netrw = true,
			},
		},
	},

	statuscolumn = {
		enabled = true,
		folds = {
			open = true,
		},
	},
})
