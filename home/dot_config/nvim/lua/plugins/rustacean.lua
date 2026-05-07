return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
						checkOnSave = false,
					},
				},
			},
		}
	end,
}
