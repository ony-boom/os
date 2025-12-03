vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	jump = { float = true },
})

vim.cmd("colorscheme kanagawa")
vim.cmd(":hi statusline guibg=NONE")
vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")
