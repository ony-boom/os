vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	input = { enabled = true },
	words = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			files = {
				ignored = true,
			},
			grep = {
        hidden = true,
				ignored = true,
			},
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
