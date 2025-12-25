return {
	{ "nanotee/sqls.nvim" },
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("lua.plugins.sql").install("go")
		end,
		config = function()
			require("dbee").setup()
		end,
	},
}
