return {
	"ThePrimeagen/harpoon",
	config = function()
		require("harpoon").setup({
			mark_branch = true,
		})

		require("telescope").load_extension('harpoon')
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
