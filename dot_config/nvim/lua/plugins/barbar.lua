return {
	'romgrk/barbar.nvim',
	dependencies = {
		'lewis6991/gitsigns.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	init = function() vim.g.barbar_auto_setup = true end,
	config = function()
		require("barbar").setup {
			animation = false,
			auto_hide = 1,
			tabpages = true,

			maximum_padding = 1,
			minimum_padding = 1,
			maximum_length = 30,
			minimum_length = 0,

		}
	end,
	opts = {},
	version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
