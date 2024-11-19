local lint = require "lint"

lint.linters_by_ft = {
  go = { "golangcilint" },
  lua = { "luacheck" },
  python = { "mypy", "ruff" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

-- :lua print(vim.inspect(require('lint').linters.luacheck.args))

lint.linters.luacheck.args = {
  unpack(lint.linters.luacheck.args),
  "--globals",
  "love",
  "vim",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
