vim.api.nvim_set_hl(0, "GoFormatVerb", { link = "SpecialChar" })
vim.fn.matchadd("GoFormatVerb", "%[-+# 0]*\\d*\\%(\\.\\d*\\)\\?[vTtbcdoOqxXUeEfFgGswp%]")
