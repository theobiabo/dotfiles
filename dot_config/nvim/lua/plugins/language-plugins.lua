return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters = {
					inkofmt = {
						command = "inko",
						args = { "fmt", "$FILENAME" },
						stdin = false,
					},
				},
				formatters_by_ft = {
					astro = { "biome" },
					css = { "biome" },
					javascript = { "biome" },
					typescript = { "biome" },
					javascriptreact = { "biome" },
					typescriptreact = { "biome" },
					["typescript.tsx"] = { "biome" },
					go = { "gofumpt", "goimports", "golines" },
					inko = { "inkofmt" },
					svelte = { "biome" },
					json = { "biome" },
					jsonc = { "biome" },
					html = { "prettier" },
					yaml = { "yamlfmt" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					swift = { "swiftformat" },
					python = { "isort", "ruff" },
					-- php = { "intelephense" },
					vue = { "biome" },
					sql = { "sqlfmt" },
					typst = { "typstfmt" },
				},

				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- 	javascript = { "biome" },
				-- 	typescript = { "biome" },
				-- 	javascriptreact = { "biome" },
				-- 	typescriptreact = { "biome" },
				-- swift = { "swiftlint" },
				python = { "ruff" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
