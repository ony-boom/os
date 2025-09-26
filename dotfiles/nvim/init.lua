-- OPTIONS
vim.o.number = true
vim.o.relativenumber = true

vim.o.termguicolors = true

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

vim.opt.foldlevel = 99

vim.undofile = true

-- PLUGINS
vim.pack.add({
  {
    src ="https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master"
  },
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/folke/snacks.nvim"
})

-- PLUGINS SETUP
require("nvim-treesitter.configs").setup({
  auto_install = true,
  ensure_installed = { "lua", "vim", "vimdoc" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

require("nvim-autopairs").setup()

require("kanagawa").setup({
  transparent = true;
  background = {
    dark = "dragon",
    light = "lotus"
  },
  colors = {
    theme = {
      all = {
        ui = {
           bg_gutter = "none"
        }
      }
    }
  },
  overrides = function(colors)
    -- set floating windows transparent
    local theme = colors.theme
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 }
      }
  end,
})

-- CONFIG
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.cmd("colorscheme kanagawa")


-- MAPPINGS
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", ":noh<CR>", {desc = "Clear searh highlights", silent = true})
vim.keymap.set("n", "<C-s>", ":w<CR>", {desc = "Save file", silent = true})
vim.keymap.set("n", "<leader>c", ":bd<CR>", {desc = "Close buffer", silent = true})

vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, {desc = "File explorer", silent = true})
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, {desc = "Find files", silent = true})
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, {desc = "Buffers", silent = true})
