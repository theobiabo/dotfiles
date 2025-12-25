local utils = require("utils")

local conform = require("conform")
local resession = require("resession")
local builtin = require("telescope.builtin")
local gitsigns = require("gitsigns")

return {
	-- Normal mode
	n = {
		["<Esc>"] = { "<cmd>nohlsearch<CR>" },

		-- Increment and decrement
		["-"] = { "<c-x>", desc = "Decrement number" },
		["+"] = { "<c-a>", desc = "Increment number" },

		-- Show yazi
		["<leader>\\"] = { "<cmd>Yazi cwd<CR>", desc = "Show Yazi file explorer" },

		-- Toggle Oil in floating window
		["<leader>o"] = {
			function()
				require("oil").toggle_float()
			end,
			desc = "Open/close Oil in floating window",
		},

		["<leader>~~"] = {
			function()
				utils.toggle_colormode()
			end,
			desc = "Toggle color mode (light/dark)",
		},
		["<leader>nx"] = {
			function()
				require("notify").dismiss()
			end,
			desc = "Dismiss notification",
		},

		-- Ufo
		["zR"] = {
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		["zM"] = {
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
		["K"] = {
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Hover to show documentation or peek folded lines",
		},

		-- Splits
		["<C-\\>"] = { "<cmd>:vsplit<CR>", desc = "Split vertically" },
		["<C-->"] = { "<cmd>:split<CR>", desc = "Split horizontally" },

		-- Keybinds to make split navigation easier.
		--  Use CTRL+<hjkl> to switch between windows
		--
		--  See `:help wincmd` for a list of all window commands
		["<C-h>"] = { "<C-w>h", desc = "Move focus to the left window" },
		["<C-l>"] = { "<C-w>l", desc = "Move focus to the right window" },
		["<C-j>"] = { "<C-w><C-j>", desc = "Move focus to the lower window" },
		["<C-k>"] = { "<C-w><C-k>", desc = "Move focus to the upper window" },

		-- Resize splits
		["<C-Right>"] = { "<C-w>8>", desc = "Increase width of window" },
		["<C-Left>"] = { "<C-w>8<", desc = "Decrease width of window" },
		["<C-Up>"] = { "<C-w>5+", desc = "Increase height of window" },
		["<C-Down>"] = { "<C-w>5-", desc = "Decrease height of window" },

		-- Misc useful maps
		["<leader>q"] = { "<Cmd>confirm q<CR>", desc = "Quit Window" },
		["<leader>Q"] = { "<cmd>confirm qa<CR>", desc = "Exit and close all tabs" },
		["<leader>n"] = { "<Cmd>enew<CR>", desc = "New File" },
		["<leader>w"] = { "<cmd>:w<CR>", desc = "Save buffer" },
		["<leader>m"] = { "<cmd>:marks<CR>", desc = "Show all marks" },
		["<leader>lH"] = {
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end,
			desc = "Toggle inlay hints",
		},

		-- Plugins mappings
		["<Leader>p"] = { "", desc = "Plugins" },
		["<Leader>pi"] = {
			function()
				require("lazy").install()
			end,
			desc = "Plugins Install",
		},
		["<Leader>ps"] = {
			function()
				require("lazy").home()
			end,
			desc = "Plugins Status",
		},
		["<Leader>pS"] = {
			function()
				require("lazy").sync()
			end,
			desc = "Plugins Sync",
		},
		["<Leader>pu"] = {
			function()
				require("lazy").check()
			end,
			desc = "Plugins Check Updates",
		},
		["<Leader>pU"] = {
			function()
				require("lazy").update()
			end,
			desc = "Plugins Update",
		},

		-- Copilot
		["<leader>cs"] = {
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			desc = "Toggle copilot suggestion",
		},
		["<leader>c."] = { "<cmd>Copilot panel<CR>", desc = "Open copilot panel" },
		["<leader>c,"] = { "<cmd>Copilot toggle<CR>", desc = "Toggle copilot" },

		-- CSV View
		["<leader>cv"] = {
			"<cmd>CsvViewToggle display_mode=border header_lnum=1<CR>",
			desc = "Toggle CSV view",
		},

		-- Spell check
		["<leader>sp"] = { utils.toggle_spellcheck, desc = "Toggle spellcheck" },
		["<leader>sz"] = { "[s1z=``", desc = "Fix spelling errors" },

		-- Movements
		-- Move between wrapped lines
		["k"] = {
			function()
				return vim.v.count == 0 and "gk" or "k"
			end,
			expr = true,
			noremap = true,
		},
		["j"] = {
			function()
				return vim.v.count == 0 and "gj" or "j"
			end,
			expr = true,
			noremap = true,
		},

		-- Tabs
		["<leader>t"] = { "", desc = "Tabs/Buffers" },
		["<leader>tp"] = { "<cmd>:BufferPin<CR>", desc = "Pin/unpin current buffer" },

		-- Go to buffer
		["<leader>t1"] = { "<cmd>:BufferGoto 1<CR>", desc = "Go to buffer 1" },
		["<leader>t2"] = { "<cmd>:BufferGoto 2<CR>", desc = "Go to buffer 2" },
		["<leader>t3"] = { "<cmd>:BufferGoto 3<CR>", desc = "Go to buffer 3" },
		["<leader>t4"] = { "<cmd>:BufferGoto 4<CR>", desc = "Go to buffer 4" },
		["<leader>t5"] = { "<cmd>:BufferGoto 5<CR>", desc = "Go to buffer 5" },
		["<leader>t6"] = { "<cmd>:BufferGoto 6<CR>", desc = "Go to buffer 6" },

		-- Close buffer
		["<leader>c"] = { "<cmd>:BufferClose<CR>", desc = "Close current buffer" },
		["<leader>tc"] = { "<cmd>:BufferClose<CR>", desc = "Close current buffer" },
		["<leader>tC"] = {
			"<cmd>:BufferCloseAllButCurrentOrPinned<CR>",
			desc = "Close all buffers but current or pinned",
		},
		["<leader>tX"] = { "<cmd>:BufferCloseAllButCurrent<CR>", desc = "Close all buffers but current" },
		["<leader>txl"] = { "<cmd>:BufferCloseBuffersRight<CR>", desc = "Close all buffers to the right" },
		["<leader>txh"] = { "<cmd>:BufferCloseBuffersLeft<CR>", desc = "Close all buffers to the left" },

		["<leader>td"] = { "<cmd>:BufferDelete<CR>", desc = "Close and delete current buffer" },
		["<leader>tr"] = { "<cmd>:BufferRestore<CR>", desc = "Restore last tab" },

		-- Order buffers
		["<leader>to"] = { "", desc = "Order buffers" },
		["<leader>tod"] = { "<cmd>:BufferOrderByDirectory<CR>", desc = "Order buffers by directory" },
		["<leader>tol"] = { "<cmd>:BufferOrderByLanguage<CR>", desc = "Order buffers by language" },
		["<leader>ton"] = { "<cmd>:BufferOrderByName<CR>", desc = "Order buffers by name" },

		-- Tab navigation
		["L"] = { "<cmd>:BufferNext<CR>", desc = "Switch to next tab" },
		["H"] = { "<cmd>:BufferPrevious<CR>", desc = "Switch to previous tab" },
		["<leader>]"] = { "<cmd>:BufferMoveNext<CR>", desc = "Move current tab to the right" },
		["<leader>["] = { "<cmd>:BufferMovePrevious<CR>", desc = "Move current tab to the left" },

		-- Trouble
		["<leader>x"] = { "", desc = "Trouble" },
		["<leader>xx"] = { "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (Trouble)" },
		["<leader>xt"] = { "<cmd>Trouble todo toggle focus=true<cr>", desc = "Todo (Trouble)" },
		["<leader>xb"] = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (trouble)" },
		["<leader>xs"] = {
			"<cmd>Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<cr>",
			desc = "Symbols (trouble)",
		},
		["<leader>xL"] = {
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		["<leader>xk"] = { "<cmd>Trouble diagnostics prev<cr>", desc = "Previous item" },
		["<leader>xj"] = { "<cmd>Trouble diagnostics next<cr>", desc = "Next item" },
		["<leader>xl"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		["<leader>xq"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

		-- Code actions and navigation
		["<leader>/"] = { "gcc", noremap = false, desc = "Toggle commenting line under cursor" },

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			noremap = true,
			desc = "Go to definition",
		},
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			noremap = true,
			desc = "Go to definition",
		},
		["gt"] = {
			"<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
			noremap = true,
			desc = "Go to definition in new tab",
		},
		["gy"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			desc = "Definition of current type",
		},
		["gl"] = {
			function()
				vim.diagnostic.open_float()
			end,
			noremap = true,
			desc = "Show diagnostic info",
		},
		["gI"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			noremap = true,
			desc = "Go to implementation",
		},
		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			noremap = true,
			desc = "Show references",
		},

		-- Language tools
		["<leader>l"] = { "", desc = "LSP" },
		["<leader>la"] = { require("actions-preview").code_actions, noremap = true, desc = "Show code action menu" },
		["<Leader>lA"] = {
			function()
				vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
			end,
			desc = "LSP source action",
		},
		["<Leader>ll"] = {
			function()
				vim.lsp.codelens.refresh()
			end,
			desc = "LSP CodeLens refresh",
		},
		["<Leader>lL"] = {
			function()
				vim.lsp.codelens.run()
			end,
			desc = "LSP CodeLens run",
		},
		["<leader>ld"] = {
			function()
				vim.diagnostic.open_float()
			end,
			noremap = true,
			desc = "Show diagnostic info",
		},
		["<leader>lf"] = {
			function()
				conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
			end,
			noremap = true,
			desc = "Format current buffer",
		},
		["<leader>lr"] = {
			function()
				vim.lsp.buf.rename()
			end,
			noremap = true,
			desc = "Rename symbol",
		},
		["<Leader>lR"] = {
			function()
				vim.lsp.buf.references()
			end,
			desc = "Search references",
		},
		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			noremap = true,
			desc = "Show signature help",
		},
		["]d"] = {
			function()
				vim.diagnostic.goto_next({ buffer = 0 })
			end,
			noremap = true,
			desc = "Go to next diagnosis",
		},
		["]D"] = {
			function()
				vim.diagnostic.goto_prev({ buffer = 0 })
			end,
			noremap = true,
			desc = "Go to previous diagnosis",
		},

		-- Jumplist mapping
		["go"] = { "<C-o>", noremap = true, desc = "Jump to previous location" },
		["gi"] = { "<C-i>", noremap = true, desc = "Jump to next location" },

		-- Session mappings
		["<leader>s"] = { "", desc = "Session" },
		["<leader>sf"] = { resession.list, desc = "List all available saved sessions" },
		["<leader>ss"] = { resession.save, desc = "Save session for current directory" },
		["<leader>sa"] = { resession.save_all, desc = "Save all sessions" },
		["<leader>st"] = { resession.save_tab, desc = "Save session for current tab" },
		["<leader>s."] = { resession.load, desc = "Load last session for current directory" },
		["<leader>sd"] = { resession.delete, desc = "Select and delete session" },

		-- Git stuff
		["<leader>g"] = { "", desc = "Git" },
		["<leader>gb"] = { "<cmd>GitBlameToggle<CR>", desc = "Toggle Git blame" },
		["<leader>gy"] = { "<cmd>GitBlameCopyCommitURL<CR>", desc = "Copy commit URL" },
		["<leader>gY"] = { "<cmd>GitBlameCopyFileURL<CR>", desc = "Copy file upstream URL" },

		-- Conflicts
		["<leader>gc"] = { "<cmd>GitConflictListQf<CR>", desc = "Show a quickfix list of conflicts" },

		["<leader>gcb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Accept both changes" },
		["<leader>gco"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Select our changes" },
		["<leader>gct"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Accept incoming changes" },
		["<leader>gcn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Select none of the changes" },

		["<leader>g]"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Go to next conflict" },
		["<leader>g["] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Go to previous conflict" },

		-- Telescope bindings
		["<leader>f"] = { "", desc = "Telescope" },
		["<leader>fF"] = { builtin.find_files, desc = "Search files" },
		["<leader>ff"] = {
			function()
				require("telescope.builtin").find_files({
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"-g",
						"!.git",
						-- for node
						"-g",
						"!node_modules",
						-- for PHP
						"-g",
						"!vendor",
						-- for Rust
						"-g",
						"!target",
						"--no-ignore",
						"--follow",
					},
				})
			end,
			desc = "Search files",
		},
		["<leader>fw"] = { builtin.grep_string, desc = "Search current word" },
		["<leader>fg"] = { builtin.live_grep, desc = "Live grep in current directory/workspace" },
		["<leader>fm"] = { "<cmd>Telescope harpoon marks<CR>", desc = "Show harpoon marks in telescope" },
		["<leader>fG"] = {
			function()
				require("git_branch").files()
			end,
			desc = "Search diff files",
		},
		["<leader>fr"] = {
			function()
				require("telescope").extensions.resession.resession()
			end,
			desc = "Search saved sessions",
		},

		-- Find and replace
		["<leader>rc"] = {
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Find and replace current word",
		},
		["<leader>rr"] = {
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "Launch grugfar as a transient buffer",
		},
		["<leader>rf"] = {
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			description = "Find and replace in current file",
		},

		-- Kulala bindings
		["<leader>k"] = { "", desc = "Kulala" },
		["<leader>kr"] = {
			function()
				require("kulala").run()
			end,
			desc = "Run the current request",
		},
		["<leader>kj"] = {
			function()
				require("kulala").jump_next()
			end,
			desc = "Jump to the next request",
		},
		["<leader>kk"] = {
			function()
				require("kulala").jump_prev()
			end,
			desc = "Jump to the previous request",
		},
		["<leader>ks"] = {
			function()
				require("kulala").scratchpad()
			end,
			desc = "Open the scratchpad",
		},
		["<leader>ky"] = {
			function()
				require("kulala").copy()
			end,
			desc = "Copy the current request as the curl command",
		},
		["<leader>kq"] = {
			function()
				require("kulala").close()
			end,
			desc = "Closes the kulala window",
		},
		["<leader>k/"] = {
			function()
				require("kulala").search()
			end,
			desc = "Search for a request",
		},

		-- Harpoon
		["<leader>h"] = { "", desc = "Harpoon" },
		["<leader>hh"] = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle Harpoon UI",
		},
		["<leader>h`"] = {
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add current file to Harpoon",
		},
		["<leader>hj"] = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Go to next file in Harpoon",
		},
		["<leader>hk"] = {
			function()
				require("harpoon.ui").nav_file(-1)
			end,
			desc = "Go to previous file in Harpoon",
		},
		["<leader>h1"] = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Go to file 1 in Harpoon",
		},
		["<leader>h2"] = {
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Go to file 2 in Harpoon",
		},
		["<leader>h3"] = {
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Go to file 3 in Harpoon",
		},
		["<leader>h4"] = {
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Go to file 4 in Harpoon",
		},
		["<leader>h5"] = {
			function()
				require("harpoon.ui").nav_file(5)
			end,
			desc = "Go to file 5 in Harpoon",
		},
		["<leader>h6"] = {
			function()
				require("harpoon.ui").nav_file(6)
			end,
			desc = "Go to file 6 in Harpoon",
		},
		["<leader>h7"] = {
			function()
				require("harpoon.ui").nav_file(7)
			end,
			desc = "Go to file 7 in Harpoon",
		},
		["<leader>h8"] = {
			function()
				require("harpoon.ui").nav_file(8)
			end,
			desc = "Go to file 8 in Harpoon",
		},
		["<leader>h9"] = {
			function()
				require("harpoon.ui").nav_file(9)
			end,
			desc = "Go to file 9 in Harpoon",
		},

		-- Gitsigns
		["]c"] = {
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end,
			desc = "Go to the next hunk",
		},
		["[c"] = {
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end,
			desc = "Go to the previous hunk",
		},
		["<leader>gs"] = { gitsigns.stage_hunk, desc = "Stage current hunk" },
		["<leader>gu"] = { gitsigns.undo_stage_hunk, desc = "Undo stage current hunk" },
		["<leader>gr"] = { gitsigns.reset_hunk, desc = "Reset current hunk" },
		["<leader>gp"] = { gitsigns.preview_hunk, desc = "Preview current hunk" },
		["<leader>gd"] = { gitsigns.diffthis, desc = "Diff current file" },

		-- Dbee
		["<leader>db"] = { "<cmd>Dbee<CR>", desc = "Open Dbee" },
		["<leader>dr"] = { "BB", desc = "Execute the current query" },

		-- Illuminate
		["]r"] = {
			function()
				require("illuminate")["goto_next_reference"](false)
			end,
			desc = "Next reference",
		},
		["[r"] = {
			function()
				require("illuminate")["goto_prev_reference"](false)
			end,
			desc = "Previous reference",
		},
		["<Leader>ur"] = {
			function()
				require("illuminate").toggle_buf()
			end,
			desc = "Toggle reference highlighting (buffer)",
		},
		["<Leader>uR"] = {
			function()
				require("illuminate").toggle()
			end,
			desc = "Toggle reference highlighting (global)",
		},
	},

	-- Select mode
	v = {
		-- Find and replace
		["<leader>/"] = { "gc", noremap = false, desc = "Toggle commenting current selection" },
		["<leader>rr"] = {
			':<C-u>lua require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })',
			description = "Launch grugfar with current selection",
		},

		-- Gitsigns
		["<leader>gs"] = {
			function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Stage current hunk",
		},
		["<leader>gr"] = {
			function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Undo stage current hunk",
		},

		-- Indentation
		["<Tab>"] = { ">gv", desc = "Indent line" },
		["<S-Tab>"] = { "<gv", desc = "Unindent line" },

		-- Format
		["<leader>lf"] = {
			function()
				conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
			end,
			noremap = true,
			desc = "Format current buffer",

			-- DBEE
			["<leader>dr"] = { "BB", desc = "Execute the current query" },
		},
	},

	-- Visual mode
	x = {
		-- Movements
		-- Move lines
		["J"] = { ":move '>+1<cr>gv-gv", desc = "Move selected line(s) down" },
		["K"] = { ":move '<-2<cr>gv-gv", desc = "Move selected line(s) down" },

		-- Find and replace
		["<leader>rr"] = {
			':<C-u>lua require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })',
			description = "Launch grugfar with current selection",
		},

		-- DBEE
		["<leader>dr"] = { "BB", desc = "Execute the current query" },
	},

	-- Insert mode
	i = {
		-- Copilot mappings
		["<C-j>"] = {
			function()
				require("copilot.suggestion").next()
			end,
			desc = "Next copilot suggestion",
		},
		["<C-k>"] = {
			function()
				require("copilot.suggestion").prev()
			end,
			desc = "Previous copilot suggestion",
		},
		["<M-CR>"] = {
			function()
				require("copilot.suggestion").accept()
			end,
			desc = "Accept copilot suggestion",
		},
		["<C-]>"] = {
			function()
				require("copilot.suggestion").dismiss()
			end,
			desc = "Dismiss copilot suggestion",
		},
	},
}
