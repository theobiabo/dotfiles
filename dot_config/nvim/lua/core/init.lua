local utils = require("utils")
local map = utils.create_keymap

local function setup_keymaps()
	local keymaps_definition = require("keymaps")
	for mode, keymaps in pairs(keymaps_definition) do
		for key, opts in pairs(keymaps) do
			local binding_opts = {}

			if opts["desc"] ~= nil then
				binding_opts["desc"] = opts["desc"]
			end

			if opts["noremap"] ~= nil then
				binding_opts["noremap"] = opts["noremap"]
			end

			if opts["expr"] ~= nil then
				binding_opts["expr"] = opts["expr"]
			end

			if opts["silent"] ~= nil then
				binding_opts["silent"] = opts["silent"]
			end

			map(mode, key, opts[1], binding_opts)
		end
	end
end

local M = {}

function M.setup()
	-- ########### LSPs ###########
	require("language_servers").setup()

	-- ########### Autocmds ###########
	require("core.autocmds").setup()

	-- ########### Keymaps ########### --
	setup_keymaps()
end

return M
