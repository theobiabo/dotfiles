-- g is equivalent to vim.g
-- opts is equivalent to vim.opt
local options = {
	g = {

		have_nerd_font = true,
		autoformat_enabled = true,

		-- Netrw Config
		netrw_banner = 0,
		netrw_browse_split = 4,
		netrw_liststyle = 3,
		netrw_winsize = -28,

		-- Use bore as clipboard provider
		clipboard = require("bore.clipboard").get_provider(),

		-- Gruvbox settings
		gruvbox_material_background = "hard",
		gruvbox_material_better_performance = 1,

		copilot_assume_mapped = true,
	},
	opts = {
		-- Line number
		number = true,
		relativenumber = true,
		clipboard = "unnamedplus", -- sync system and Neovim clipboard
		termguicolors = true,
		background = "dark",

		spell = false,
		wrap = true,
		cursorline = false,
		ruler = true,
		showmatch = true,
		scrolloff = 8,

		tabstop = 4,
		shiftwidth = 4,
		expandtab = false,
		smarttab = true,

		-- Code folding using Treesitter
		-- foldenable = false,
		-- foldmethod = "expr",
		-- foldexpr = "v:lua.vim.treesitter.foldexpr()",
		-- foldcolumn = "0",
		-- foldtext = "",
		-- foldnestmax = 3,
		-- foldlevel = 99,

		-- Code folding using nvim-ufo
		-- foldcolumn = "1", -- '0' is not bad
		-- foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value,
		-- foldlevelstart = 99,
		-- foldenable = true,

		-- EOL fix
		fixeol = false,

		fileformats = "dos,unix",
		mouse = "a", -- allow mouse usage
		showmode = false, -- hide mode since it is in status line,

		-- Enable break indent
		breakindent = true,

		-- Save undo history
		undofile = true,

		-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
		ignorecase = true,
		smartcase = true,

		-- Decrease update time
		updatetime = 250,

		-- Decrease mapped sequence wait time
		-- Displays which-key popup sooner
		timeoutlen = 300,

		-- Configure how new splits should be opened
		splitright = true,
		splitbelow = true,

		-- Preview substitutions live, as you type!
		inccommand = "split",

		-- Set highlight on search, but clear on pressing <Esc> in normal mode
		hlsearch = true,
	},
	extensions = {
		["mdx"] = "markdown",
		["v"] = "v",
		["dbml"] = "dbml",
	},
}

local M = {}

-- Loads vim.g and vim.opt
function M.load()
	for key, value in pairs(options.g) do
		vim.g[key] = value
	end

	for key, value in pairs(options.opts) do
		vim.opt[key] = value
	end

	vim.filetype.add({
		extension = options.extensions,
	})
end

return M
