vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "master",
	},
})

require("nvim-treesitter.configs").setup({
	auto_install = true,
	sync_install = false,

	modules = {},
	ignore_install = {},

	ensure_installed = { "lua", "vim", "vimdoc" },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
