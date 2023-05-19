local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  print("lspconfig not found")
  return
end

local servers = { "clangd", "hls", "rust_analyzer", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
