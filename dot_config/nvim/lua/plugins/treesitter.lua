return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "master",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"phpdoc",
				"php",
				"css",
				"html",
				"javascript",
				"lua",
				"regex",
				"go",
				"rust",
				"typescript",
				"typst",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
