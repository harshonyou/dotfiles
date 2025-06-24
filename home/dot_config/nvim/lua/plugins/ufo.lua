return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		"nvim-treesitter/nvim-treesitter",
	},
	event = "BufReadPost",
	config = function()
		vim.o.foldcolumn = "0" -- show foldcolumn
		vim.o.foldlevel = 99 -- set high fold level to enable folding
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true -- enable folding

		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

		require("ufo").setup({
			provider_selector = function(_, filetype, _)
				-- Use Treesitter for code, indent for others
				return { "treesitter", "indent" }
			end,
		})
	end,
}
