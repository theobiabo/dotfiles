return {
	"gbprod/phpactor.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		{
			"williamboman/mason.nvim",
			opts_extend = { "ensure_installed" },
			opts = {
				ensure_installed = { "phpactor" },
			},
		},
	},
	opts = {
		install = {
			bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/phpactor.phar",
		},
	},
}
