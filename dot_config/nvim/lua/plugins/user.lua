return {
	{ "inko-lang/inko.vim" },
	{ "jidn/vim-dbml" },
	{
		"rcarriga/nvim-notify",
		as = "notify",
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				fps = 60,
				timeout = 2000,
				background_colour = "#181825",
				top_down = false,
			})
		end,
	},
	{ "andweeb/presence.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "tpope/vim-sleuth", lazy = false },
	{
		"wakatime/vim-wakatime",
	},
	{ "aznhe21/actions-preview.nvim" },
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			require("grug-far").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
	{
		"mistweaverco/kulala.nvim",
		-- config = function()
		-- require("kulala").setup()
		-- end,
	},
	{ "tpope/vim-surround" },
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({ enabled = false })
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"stevearc/resession.nvim",
		config = function()
			require("resession").setup({
				autosave = {
					enabled = true,
					interval = 60,
					notify = false,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"chomosuke/typst-preview.nvim",
		version = "1.*",
		build = function()
			require("typst-preview").update()
		end,
		filetypes = { "typst" },
		lazy = true,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- OR 'ibhagwan/fzf-lua',
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
		opts = function()
			return {
				delay = 200,
				min_count_to_highlight = 2,
				large_file_cutoff = 2000,
				large_file_overrides = { providers = { "lsp" } },
				should_enable = function(_bufnr)
					return true
				end,
			}
		end,
	},
}
