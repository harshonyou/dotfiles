return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		-- Python adapter via global venv debugpy
		dap_python.setup("/Users/aei/.poetry-global/.venv/bin/python")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP: Step over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP: Step out" })
		vim.keymap.set("n", "<leader>dq", function()
			dap.terminate()
			dapui.close()
		end, { desc = "DAP: Quit" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
		vim.keymap.set("n", "<leader>dt", dap_python.test_method, { desc = "DAP: Debug test method" })
	end,
}
