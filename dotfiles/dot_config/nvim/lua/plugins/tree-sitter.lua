vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

local to_be_highlighted = {
	"typescript",
	"javascript",
	"jsx",
	"tsx",
	"svelte",
	"go",
	"nix",
	"markdown",
	"json",
	"css",
	"html",
	"toml",
	"yaml",
	"lua",
	"kdl",
  "prisma"
}

local tree_sitter = require("nvim-treesitter")

tree_sitter.install(to_be_highlighted)

local function try_start(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	if vim.tbl_contains(to_be_highlighted, ft) then
		pcall(vim.treesitter.start, buf)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = to_be_highlighted,
	callback = function(args)
		try_start(args.buf)
	end,
})

-- The FileType event for the buffer opened on startup (e.g. `nvim file.ts`)
-- can fire before this plugin loads, so the autocmd above misses it. Kick off
-- highlighting for any buffers that are already open.
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
	if vim.api.nvim_buf_is_loaded(buf) then
		try_start(buf)
	end
end
