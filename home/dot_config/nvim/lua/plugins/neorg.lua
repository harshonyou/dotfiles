return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-neorg/tree-sitter-norg",
			build = function()
				local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
				vim.fn.mkdir(parser_dir, "p")
				local plugin_dir = vim.fn.stdpath("data") .. "/lazy/tree-sitter-norg"
				os.execute(
					"cc -shared -fPIC -o "
						.. parser_dir
						.. "/norg.so -I"
						.. plugin_dir
						.. "/src "
						.. plugin_dir
						.. "/src/parser.c -x c++ "
						.. plugin_dir
						.. "/src/scanner.cc -lstdc++"
				)
			end,
		},
		{
			"nvim-neorg/tree-sitter-norg-meta",
			build = function()
				local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
				vim.fn.mkdir(parser_dir, "p")
				local plugin_dir = vim.fn.stdpath("data") .. "/lazy/tree-sitter-norg-meta"
				os.execute(
					"cd " .. plugin_dir .. " && tree-sitter build --output " .. parser_dir .. "/norg_meta.so"
				)
			end,
		},
	},
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
				["core.journal"] = {
					config = {
						workspace = "notes",
					},
				},
				["core.summary"] = {},
				["core.completion"] = {
					config = { engine = "nvim-cmp" },
				},
				["core.integrations.nvim-cmp"] = {},
				["core.integrations.treesitter"] = {},
				["core.keybinds"] = {
					config = {
						hook = function(keybinds)
							-- <CR> taken by treesitter incremental selection
							keybinds.remap_key("core.esupports.hop", "n", "<CR>", "gl")
						end,
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "norg",
			callback = function(ev)
				vim.keymap.set("n", "gl", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = ev.buf, desc = "Follow Neorg link" })

			end,
		})

		-- Journal keymaps (localleader = \)
		vim.keymap.set("n", "<LocalLeader>jt", "<cmd>Neorg journal today<CR>", { desc = "Journal today" })
		vim.keymap.set("n", "<LocalLeader>jy", "<cmd>Neorg journal yesterday<CR>", { desc = "Journal yesterday" })
		vim.keymap.set("n", "<LocalLeader>ji", "<cmd>Neorg index<CR>", { desc = "Neorg index" })
	end,
}
