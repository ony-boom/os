vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.7.0" },
})

local servers = { "lua_ls", "nil_ls" }

vim.lsp.enable(servers)

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
})

for _, server in ipairs(servers) do
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end


require("lsp.mappings")
