local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand "~/.config"
local opt = vim.opt

opt.relativenumber = true
opt.colorcolumn = "80"

opt.clipboard = "unnamedplus"

opt.scrolloff = 10
opt.breakindent = true

-- opt.wildignore:append { "" }

opt.undofile = true
opt.undodir = { prefix .. "/nvim/.undo//" }
opt.undolevels = 10000
