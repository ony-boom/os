vim.pack.add({ "https://github.com/nvim-mini/mini.icons", "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup()

require("plugins.autopairs")
require("plugins.tree-sitter")
require("plugins.snacks")
require("plugins.formatting")
require("plugins.bufferline")
