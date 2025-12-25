return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{ "nvim-neotest/nvim-nio" },
		{
			"leoluz/nvim-dap-go",
			ft = "go",
			config = function()
				require("dap-go").setup()
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapgo = require("dap-go")

		dapui.setup()
		dapgo.setup()

		-- Listeners
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,

	keys = {
		{ "<leader>d", "", desc = "Debugger (DAP)" },
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint()
			end,
			desc = "Set Breakpoint",
		},
		{
			"<leader>dC",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set Conditional Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "Open REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").close()
			end,
			desc = "Stop",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>dd",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle UI",
		},
		{
			"<leader>dgt",
			function()
				require("dap-go").debug_test()
			end,
			desc = "Debug Test (Go)",
		},
		{
			"<leader>dgr",
			function()
				require("dap-go").debug_run()
			end,
			desc = "Debug Run (Go)",
		},
	},
}
