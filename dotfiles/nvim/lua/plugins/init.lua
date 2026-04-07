vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

require("gitsigns").setup()
require("mini.icons").setup()
require("ibl").setup()

require("plugins.autopairs")
require("plugins.tree-sitter")
require("plugins.snacks")
require("plugins.formatting")
require("plugins.bufferline")
require("plugins.ai")
