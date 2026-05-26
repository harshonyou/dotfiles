return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			-- markdown = { "prettierd" },
			markdown = { "mdformat" },
			go = { "gofumpt" },
			cpp = { "clang_format" },
			c = { "clang_format" },
			typst = { "typstyle" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
