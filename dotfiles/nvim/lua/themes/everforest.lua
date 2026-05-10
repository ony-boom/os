vim.pack.add({
	"https://github.com/sainnhe/everforest",
})

vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 2

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("custom_highlights_everforest", {}),
	pattern = "everforest",
	callback = function()
		local config = vim.fn["everforest#get_configuration"]()
		local palette = vim.fn["everforest#get_palette"](config.background, config.colors_override)
		local set_hl = vim.fn["everforest#highlight"]

		set_hl("Pmenu", palette.fg, palette.none)
		set_hl("PmenuSbar", palette.none, palette.none)
		set_hl("PmenuThumb", palette.none, palette.grey0)
	end,
})
