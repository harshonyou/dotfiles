return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"c",
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"python",
			"markdown",
			"markdown_inline",
			"go",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python", "markdown", "go" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
