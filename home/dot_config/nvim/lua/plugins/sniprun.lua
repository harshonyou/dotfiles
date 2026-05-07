return {
	"michaelb/sniprun",
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	config = function()
		require("sniprun").setup({
			selected_interpreters = { "Python3_fifo" }, -- instead of default Python3_original
			repl_enable = { "Python3_fifo" }, -- REPL works without klepto
			display = {
				"VirtualTextOk", -- show success inline
				-- "VirtualTextErr",
				"Classic", -- also show in command-line area
			},
			show_no_output = {
				"VirtualTextOk", -- ← force display even for lines like `x = 10`
			},
			-- repl_enable = { "Python3_original" },
			-- interpreter_options = {
			-- 	Python3_original = {
			-- 		error_truncate = "auto",
			-- 	},
			-- },
			-- display = {
			-- 	"Classic",
			-- 	"VirtualTextOk",
			-- },
		})
	end,
}
