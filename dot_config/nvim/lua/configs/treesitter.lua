local options = {
  ensure_installed = {
    "bash",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "javascript",
    "lua",
    "luadoc",
    "markdown",
    "printf",
    "python",
    "typescript",
    "tsx",
    "vim",
    "vimdoc",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
