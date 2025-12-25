return {
	"onsails/lspkind-nvim",
	config = function()
		local lspkind = require("lspkind")
		local cmp = require("cmp")

		lspkind.init({
			symbol_map = { Copilot = "" },
		})

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						menu = function()
							return math.floor(0.45 * vim.o.columns)
						end,
						abbr = 50, -- actual suggestion item
					},
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
				}),
			},
		})
	end,
}
