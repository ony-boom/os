vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/folke/which-key.nvim",
})

require("which-key").setup()

require("mini.icons").setup()
require("ibl").setup()

require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.tree-sitter")
require("plugins.snacks")
require("plugins.formatting")
require("plugins.bufferline")
require("plugins.ai")
