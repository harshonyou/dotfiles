return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>sm", -- feel free to change the keybinding
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle split/join with TreeSJ",
		},
		{
			"<leader>sj", -- feel free to change the keybinding
			function()
				require("treesj").join()
			end,
			desc = "Toggle join with TreeSJ",
		},
		{
			"<leader>sk", -- feel free to change the keybinding
			function()
				require("treesj").split()
			end,
			desc = "Toggle split with TreeSJ",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false, -- we use custom keys
			max_join_length = 120,
		})
	end,
}
