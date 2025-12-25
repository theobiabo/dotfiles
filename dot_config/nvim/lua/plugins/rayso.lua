return {
	"TobinPalmer/rayso.nvim",
	cmd = { "Rayso" },
	config = function()
		require("rayso").setup {
			open_cmd = "chromium",
			base_url = "https://ray.so",
			options = {
				title = "~/trulyao/code",
				background = true,
				theme = "vercel",
				dark_mode = true,
				padding = 32,
				logging_enabled = false,
				logging_path = "/tmp",
				logging_file = "rayso.log",
			},
		}
	end,
}
