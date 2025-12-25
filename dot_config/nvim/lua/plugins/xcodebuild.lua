return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim",
	},
	lazy = false,
	config = function()
		require("xcodebuild").setup({})
	end,
	keys = {
		{ "<leader>z", desc = "Xcodebuild" },
		{ "<leader>zz", "<cmd>XcodebuildPicker<cr>", desc = "Show All Xcodebuild Actions" },
		{ "<leader>za", "<cmd>XcodebuildCodeActions<cr>", desc = "Show Code Actions" },
		{ "<leader>zl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Xcodebuild Logs" },
		{ "<leader>zb", "<cmd>XcodebuildBuild<cr>", desc = "Build Project" },
		{ "<leader>zB", "<cmd>XcodebuildCleanBuild<cr>", desc = "Build Project (Clean)" },
		{ "<leader>zr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project" },
		{ "<leader>zt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
		{ "<leader>zT", "<cmd>XcodebuildTestClass<cr>", desc = "Run This Test Class" },
		{ "<leader>zd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
		{ "<leader>zp", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", desc = "Generate & Run Preview" },
		{ "<leader>zc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Toggle Code Coverage" },
		{ "<leader>zC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", desc = "Show Code Coverage Report" },
		{ "<leader>zx", "<cmd>XcodebuildCancel<cr>", desc = "Cancel current operation" },
	},
}
