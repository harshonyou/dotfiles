local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand "~/.config"

vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 10
vim.opt.breakindent = true

-- vim.opt.wildignore:append { "" }

vim.opt.undofile = true
vim.opt.undodir = { prefix .. "/nvim/.undo//" }
vim.opt.undolevels = 10000
