local options = {
  formatters_by_ft = {
    go = { "gofumpt", "goimports-reviser", "golines" },
    lua = { "stylua" },
    python = { "black", "isort" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  formatters = {
    -- Go
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
    golines = {
      prepend_args = { "--max-len=80" },
    },

    -- Python
    black = {
      prepend_args = {
        "--fast",
        "--line-length",
        "80",
      },
    },
    isort = {
      prepend_args = {
        "--profile",
        "black",
      },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
