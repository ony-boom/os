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

vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "File explorer", silent = true })

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find files", silent = true })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers", silent = true })

vim.keymap.set("n", "<leader>fw", function()
	Snacks.picker.grep()
end, { desc = "Grep", silent = true })

vim.keymap.set("n", "<leader>fo", function()
	Snacks.picker.recent()
end, { desc = "recent file", silent = true })

vim.keymap.set("n", "<leader>h", function()
	Snacks.picker.help()
end, { desc = "Vim help", silent = true })

vim.keymap.set("n", '"', function()
	Snacks.picker.registers()
end, { desc = "Registers", silent = true })
