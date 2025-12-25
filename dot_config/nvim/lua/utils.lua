local M = {}

-- This file really shows how great I am at Lua
--
-- /s
function M.create_keymap(mode, key, cmd, opts)
	opts = opts or {}

	-- set `silent` and `noremap` by default
	local noremap = opts["noremap"] or false
	opts["remap"] = not noremap

	if opts["silent"] == nil then
		opts["silent"] = true
	end

	vim.keymap.set(mode, key, cmd, opts)
end

function M.get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end

function M.toggle_spellcheck()
	if vim.opt.spell:get() then
		vim.opt_local.spell = false
		vim.opt_local.spelllang = "en"
	else
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_gb" }
	end
end

function M.toggle_colormode()
	if vim.opt.background:get() == "dark" then
		vim.opt.background = "light"
	else
		vim.opt.background = "dark"
	end
end

return M
