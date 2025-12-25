local M = {}

function M.setup()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- For nvim-ufo
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	-- Setup local servers (i.e. not installed with mason)
	local local_servers = require("language_servers.options").local_servers()
	for _, server_name in ipairs(local_servers) do
		local opts = require("language_servers.options").merge_opts(server_name, { capabilities = capabilities })
		require("lspconfig")[server_name].setup(opts)
	end
end

return M
