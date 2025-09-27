vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	input = { enabled = true },
	words = { enabled = true },
	picker = { enabled = true },

	statuscolumn = {
		enabled = true,
		folds = {
			open = true,
		},
	},
})
