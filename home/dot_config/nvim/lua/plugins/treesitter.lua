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
			"yaml",
			"dockerfile",
			"typst",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python", "markdown", "go", "yaml", "dockerfile", "typst" },
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter.indent'.get_indent(v:lnum)"
			end,
		})
	end,
}
