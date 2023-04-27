local status, null_ls = pcall(require, "null-ls")
if not status then
  print("null-ls not found")
  return
end

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  -- Web development
  formatting.prettier.with({
    filetypes = { "html", "json", "scss", "css", "javascript", "javascriptreact", "typescript" },
  }),

  -- Lua
  formatting.stylua,
  lint.luacheck.with({ extra_args = { "--global vim" } }),

  -- Shell
  formatting.shfmt,
  lint.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

  -- c/c++/java
  formatting.clang_format.with({
    filetypes = {
      "java",
      "c",
      "cpp",
      "proto",
    }
  }),

  -- haskell
  formatting.stylish_haskell,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
