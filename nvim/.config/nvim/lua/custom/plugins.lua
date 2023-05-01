local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",

    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- low level
        "cpp",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",

      config = function()
        require "custom.configs.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",

    opts = {
      ensure_installed = {
        "lua-language-server",
        "clangd",
        "clang-format",
        "prettier",
        "stylua",
        "shfmt",
        "luacheck",
        "haskell-language-server",
        "rustfmt"
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup {
        -- show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        -- show_trailing_blankline_indent = false,
        -- char_highlight_list = {
        --   "IndentBlanklineIndent1",
        --   "IndentBlanklineIndent2",
        --   "IndentBlanklineIndent3",
        --   "IndentBlanklineIndent4",
        --   "IndentBlanklineIndent5",
        --   "IndentBlanklineIndent6",
        -- },
      }
    end,
  },

  {
    "CRAG666/code_runner.nvim",

    config = function()
      require("code_runner").setup {
        focus = false,
        filetype = {
          -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          -- python = "python3 -u",
          -- typescript = "deno run",
          -- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
          dart = "dart $dir/$fileName",
          excluded_buftypes = { "message" },
        },
      }
    end,
  },

  {
    "gelguy/wilder.nvim",

    keys = { ":", { ";", ":", mode = "n", desc = "command mode" } },

    config = function()
      local wilder = require "wilder"

      wilder.setup {
        next_key = "<Down>",
        accept_key = "<Right>",
        reject_key = "<Left>",
        previous_key = "<Up>",
        modes = { ":", "/", "?" },
      }

      wilder.set_option(
        "renderer",

        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          pumblend = 20,
          highlighter = wilder.basic_highlighter(),
          highlights = {
            border = "Normal", -- highlight to use for the border
          },
          border = "rounded",
        })
      )
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

return plugins
