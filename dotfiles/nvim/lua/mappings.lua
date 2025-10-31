vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear searh highlights", silent = true })
vim.keymap.set("n", "<C-s>", ":update<CR>", { desc = "Save file", silent = true })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Close buffer", silent = true })

vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "File explorer", silent = true })

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find files", silent = true })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers", silent = true })

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true })
end, { desc = "Format document", silent = true })

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
