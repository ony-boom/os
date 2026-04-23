vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear searh highlights", silent = true })
vim.keymap.set("n", "<C-s>", ":update<CR>", { desc = "Save file", silent = true })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Close buffer", silent = true })
vim.keymap.set("x", "Y", '"+y', { desc = "Copy selection to system clipboard", silent = true })
