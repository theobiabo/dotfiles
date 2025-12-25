vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

-- ############# Lazy.nvim ############## --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import/override user plugins
		{ import = "plugins" },
	},

	defaults = {
		version = "*",
	},
})

require("core.opts").load()

-- Use nvim-notify as default notification handler
vim.notify = require("notify")
-- vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("oxocarbon")
vim.cmd.colorscheme("vesper")

require("core").setup()
