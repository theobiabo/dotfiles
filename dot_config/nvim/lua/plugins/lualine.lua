-- Disable git blame virtual text
vim.g.gitblame_display_virtual_text = 0

local function macro_recording()
	local mode = require("noice").api.statusline.mode.get()
	if mode then
		return string.match(mode, "^recording @.*") or ""
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					macro_recording,
					{ require("gitblame").get_current_blame_text, cond = require("gitblame").is_blame_text_available },
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "f-person/git-blame.nvim" },
	},
}
