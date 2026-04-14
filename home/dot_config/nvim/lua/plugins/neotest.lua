return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	keys = {
		{
			"<leader>tr",
			function() require("neotest").run.run() end,
			desc = "Neotest: Run nearest test",
		},
		{
			"<leader>tf",
			function() require("neotest").run.run(vim.fn.expand("%")) end,
			desc = "Neotest: Run file",
		},
		{
			"<leader>ts",
			function() require("neotest").summary.toggle() end,
			desc = "Neotest: Toggle summary",
		},
		{
			"<leader>to",
			function() require("neotest").output_panel.toggle() end,
			desc = "Neotest: Toggle output panel",
		},
		{
			"<leader>td",
			function() require("neotest").run.run({ strategy = "dap" }) end,
			desc = "Neotest: Debug nearest test",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
					python = function()
						local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
						if vim.fn.filereadable(venv_python) == 1 then
							return venv_python
						end
						return "/Users/aei/.poetry-global/.venv/bin/python"
					end,
				}),
			},
		})
	end,
}
