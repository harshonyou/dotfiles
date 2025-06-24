return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Custom header (you can replace this with ASCII art if you want)
		dashboard.section.header.val = {
			"    ▄████▄   ▒█████   ███▄    █ ▓█████▄ ",
			"   ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ ▒██▀ ██▌",
			"   ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒░██   █▌",
			"   ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒░▓█▄   ▌",
			"   ▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░░▒████▓ ",
			"   ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▒▓  ▒ ",
			"     ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░ ░ ▒  ▒ ",
			"   ░        ░ ░ ░ ▒     ░   ░ ░  ░ ░  ░ ",
			"   ░ ░          ░ ░           ░    ░   ",
			"   ░                              ░    ",
		}

		local hydra = {
			"                                   ",
			"                                   ",
			"                                   ",
			"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
			"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
			"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
			"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
			"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
			"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
			"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
			" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
			" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
			"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
			"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
			"                                   ",
		}

		local stars = {
			"               *",
			"                     *",
			"",
			"         .                      .",
			"         .                      ;",
			"         :                  - --+- -",
			"         !           .          !",
			"         |        .             .",
			"         |_         +",
			"      ,  | `.",
			"--- --+-<#>-+- ---  --  -",
			"      `._|_,'",
			"         T",
			"         |",
			"         !",
			"         :         . :",
			"         .       *",
		}

		dashboard.section.header.val = stars
		dashboard.section.header.opts = { position = "center", hl = "AlphaHeader" }

		-- dashboard.section.header.opts = { hl = "AlphaHeader", position = "center" }

		-- Buttons
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find File", ":FzfLua files<CR>"),
			dashboard.button("g", "󰱼  Live Grep", ":FzfLua live_grep<CR>"),
			dashboard.button("r", "󰙰  Recent Files", ":FzfLua oldfiles<CR>"),
			dashboard.button("s", "󰁯  Restore Session", "<Cmd>SessionRestore<CR>"),
			dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
		}

		dashboard.section.buttons.opts = {
			hl = "AlphaButton",
			hl_shortcut = "AlphaShortcut",
		}

		-- Footer
		dashboard.section.footer.type = "group"
		dashboard.section.footer.val = function()
			local stats = require("lazy").stats()
			local datetime = os.date("  %A, %d %B %Y    %H:%M")
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			local plugin_line = "  " .. stats.loaded .. " / " .. stats.count .. " plugins loaded in " .. ms .. "ms"

			return {
				{
					type = "text",
					val = " ",
				},
				{
					type = "text",
					val = datetime,
					opts = { position = "center", hl = "AlphaFooterDate" },
				},
				{
					type = "text",
					val = plugin_line,
					opts = { position = "center", hl = "AlphaFooterPlugins" },
				},
				{
					type = "text",
					val = "AEI",
					opts = { position = "center", hl = "AlphaFooterSignature" },
				},
			}
		end

		dashboard.section.footer.opts = { hl = "Type" }

		-- Hide statusline/tabline when dashboard is visible
		-- vim.cmd([[autocmd User AlphaReady set showtabline=0 | set laststatus=0]])
		-- vim.cmd([[autocmd BufUnload <buffer> set showtabline=2 | set laststatus=2]])

		-- Custom highlights
		-- Muted, elegant color palette
		-- ASCII art: pale violet (like starlight)
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7dfaf8", italic = true })
		-- vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ff4a6b", italic = true })

		-- Buttons
		vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#7dfaf8", bold = true }) -- Soft white
		vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#7dfaf8", italic = true }) -- Sky blue

		-- Footer
		vim.api.nvim_set_hl(0, "AlphaFooterDate", { fg = "#4e694c", bold = true }) -- Green tea
		vim.api.nvim_set_hl(0, "AlphaFooterPlugins", { fg = "#91684e", bold = true }) -- Warm amber
		vim.api.nvim_set_hl(0, "AlphaFooterSignature", { fg = "#8433ff", italic = true }) -- Rose pink

		vim.b.ministatusline_disable = true

		alpha.setup(dashboard.config)
	end,
}
