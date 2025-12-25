return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.x",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "mrloop/telescope-git-branch.nvim" },
		{ "scottmckendry/telescope-resession.nvim" },
	},
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				resession = {
					prompt_title = "Find Sessions",
					dir = "dirsession",
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("git_branch")
		require("telescope").load_extension("resession")
	end,
}
