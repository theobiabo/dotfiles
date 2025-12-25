local M = {}

function M.use_swift_template()
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
		group = vim.api.nvim_create_augroup("SwiftTemplate", { clear = true }),
		pattern = "*.swift",
		callback = function(ev)
			local lines = #vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)

			if lines > 1 then
				return
			end

			local filename = string.match(ev.file, "([^/]*)%.swift")
			local name = filename

			local basepath = os.getenv("HOME") .. "/.config/nvim/assets/xcodebuild/templates/"
			local templates = { "View", "ViewModel", "Builder", "Router", "Tests", "Spec" }

			local template
			local cursor

			for _, templateSuffix in ipairs(templates) do
				if vim.endswith(filename, templateSuffix) then
					template = vim.fn.readfile(basepath .. string.lower(templateSuffix) .. ".txt")
					name = string.gsub(name, templateSuffix, "")
					break
				end
			end

			template = template or vim.fn.readfile(basepath .. "empty.txt")

			for i = 1, #template do
				template[i] = string.gsub(template[i], "{date}", os.date("%d/%m/%Y"))
				template[i] = string.gsub(template[i], "{filename}", filename)
				template[i] = string.gsub(template[i], "{name}", name)

				if cursor == nil and string.find(template[i], "{cursor}") then
					cursor = { i, tonumber(string.find(template[i], "{cursor}")) + 1 }
				end
				template[i] = string.gsub(template[i], "{cursor}", " ")
			end

			vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, template)

			if cursor then
				vim.api.nvim_win_set_cursor(0, cursor)
			end

			vim.cmd("w")
		end,
	})
end

function M.setup()
	-- Highlight on yank
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- Session loading (on enter and on exit)
	local resession = require("resession")
	local session_name = require("utils").get_session_name

	-- Auto-load sesison for current directory or branch (depending on where we"re at)
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Only load the session if nvim was started with no args
			if vim.fn.argc(-1) == 0 then
				resession.load(session_name(), { dir = "dirsession", silence_errors = true })
			end
		end,
	})

	-- Autosave on exit
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			resession.save(session_name(), { dir = "dirsession", notify = false })
		end,
	})

	M.use_swift_template()

	-- Go imports and formatting on save
	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	pattern = "*.go",
	-- 	callback = function()
	-- 		require("go.format").goimports()
	-- 	end,
	-- 	group = vim.api.nvim_create_augroup("GoFormat", {}),
	-- })
end

return M
