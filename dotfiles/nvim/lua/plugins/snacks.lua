vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	input = { enabled = true },
	words = { enabled = true },
	picker = {
		enabled = true,
		sources = {
			grep = {
				hidden = true,
			},
			explorer = {
        ignored = true,
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
