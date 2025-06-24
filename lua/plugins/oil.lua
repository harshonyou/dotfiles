return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		keymaps = {
			["<C-c>"] = false,
			["q"] = "actions.close",
			["<Esc>"] = "actions.close",
			["<Right>"] = "actions.select",
			["<Left>"] = "actions.parent",
		},
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
		skip_confirm_for_simple_edits = true,
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
