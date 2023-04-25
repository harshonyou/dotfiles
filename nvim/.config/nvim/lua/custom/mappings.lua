local M = {}

M.general = {
  n = {
    ["<C-d>"] = { "<C-d>zz", "Cursor always in the middle" },
    ["<C-u>"] = { "<C-u>zz", "Cursor always in the middle" },

    ["n"] = { "nzzzv", "Cursor always in the middle" },
    ["N"] = { "Nzzzv", "Cursor always in the middle" },

    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },

    -- ["<Tab>"] = { ">>", "Tab space" },
    -- ["<S-Tab>"] = { "<<", "Tab space but backwards" },

    ["<C-a>"] = { "gg<S-v>G", "Select all" },

    ["J"] = { "mzJ`z", "Keep the cursor at same position" },
  },

  i = {
    -- ["en"] = { "<ESC>", "escape insert mode" },
  },

  v = {
    ["J"] = { ":m '<-2<CR>gv=gv", "Move a block upwards" },
    ["K"] = { ":m '>+1<CR>gv=gv", "Move a block downwards" },
  },
}

M.nvterm = {
  n = {
    ["<leader>gc"] = {
      function()
        require("nvterm.terminal").send(
          "clear && g++ -o out '" .. vim.fn.expand "%" .. "' && ./out && rm out",
          "vertical"
        )
      end,

      "compile & run a cpp file",
    },
  },
}

return M
