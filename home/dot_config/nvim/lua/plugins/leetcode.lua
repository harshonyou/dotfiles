return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = true,
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "python3",
		storage = {
			home = vim.fn.expand("~/leetcode"),
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},
		injector = {
			["python3"] = {
				before = true,
			},
		},
		hooks = {
			["enter"] = {},
			["question_enter"] = {},
			["leave"] = {},
		},
		keys = {
			toggle = { "q" },
			confirm = { "<CR>" },
			reset_testcases = "r",
			use_testcase = "U",
			focus_testcases = "<M-t>",
			focus_result = "<M-r>",
		},
	},
}
