return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		requires = {
			"copilotlsp-nvim/copilot-lsp",
		},
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
				},
			})
		end,
	},
}
