return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- load before other plugins
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- options: latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = true, -- removes ~ at end of buffer
			term_colors = true,
			dim_inactive = {
				enabled = false,
			},
			custom_highlights = function(_)
				return {
					-- Base UI
					Normal = { fg = "#EDEDED", bg = "#1A1A1A" },
					NormalNC = { fg = "#EDEDED", bg = "#1A1A1A" },
					Cursor = { fg = "#1A1A1A", bg = "#FFD700" },
					Visual = { bg = "#FFD7AF" },
					CursorLine = { bg = "#222222" },
					CursorLineNr = { fg = "#FFD700", bold = true },
					LineNr = { fg = "#5A5A5A" },
					WinSeparator = { fg = "#2F2F2F", bg = "#1A1A1A" },
					SignColumn = { bg = "#1A1A1A" },

					-- Search
					Search = { fg = "#1A1A1A", bg = "#FFD700", bold = true },
					IncSearch = { fg = "#1A1A1A", bg = "#FF6C75", bold = true },

					-- Popup & Float
					Pmenu = { fg = "#EDEDED", bg = "#2A2A2A" },
					PmenuSel = { fg = "#1A1A1A", bg = "#FFD700" },
					NormalFloat = { fg = "#EDEDED", bg = "#1A1A1A" },
					FloatBorder = { fg = "#5C78FF", bg = "#1A1A1A" },

					-- Statusline
					StatusLine = { fg = "#EDEDED", bg = "#1E1E1E" },
					StatusLineNC = { fg = "#5A5A5A", bg = "#1A1A1A" },

					-- Syntax
					Comment = { fg = "#9E9E9E", italic = true },
					Constant = { fg = "#E5C07B" },
					String = { fg = "#98C379" },
					Character = { fg = "#98C379" },
					Number = { fg = "#E5C07B" },
					Boolean = { fg = "#FF6C75" },
					Identifier = { fg = "#61AFEF" },
					Function = { fg = "#61AFEF", bold = true },
					Statement = { fg = "#C678DD", bold = true },
					Keyword = { fg = "#C678DD", italic = true },
					Operator = { fg = "#FFD700" },
					Type = { fg = "#56B6C2" },
					Special = { fg = "#62CFF3" },
					Delimiter = { fg = "#ABB2BF" },
					Underlined = { fg = "#62CFF3", underline = true },

					-- Diagnostics
					DiagnosticError = { fg = "#E06C75" },
					DiagnosticWarn = { fg = "#FFD700" },
					DiagnosticInfo = { fg = "#5C78FF" },
					DiagnosticHint = { fg = "#62CFF3" },
					DiagnosticVirtualTextError = { fg = "#9A4757", bg = "#1A1A1A" },
					DiagnosticVirtualTextWarn = { fg = "#B89B64", bg = "#1A1A1A" },
					DiagnosticVirtualTextHint = { fg = "#4A8C99", bg = "#1A1A1A" },

					-- GitSigns
					GitSignsAdd = { fg = "#98C379" },
					GitSignsChange = { fg = "#E5C07B" },
					GitSignsDelete = { fg = "#E06C75" },

					-- Diff
					DiffAdd = { bg = "#1E1E1E" },
					DiffChange = { bg = "#2A2A2A" },
					DiffDelete = { bg = "#2F2F2F" },
					DiffText = { fg = "#FFD700", bg = "#2A2A2A", bold = true },

					-- Treesitter context, LSP highlights
					LspReferenceText = { bg = "#2A2A2A" },
					LspReferenceRead = { bg = "#2A2A2A" },
					LspReferenceWrite = { bg = "#2A2A2A" },

					-- Telescope
					TelescopeNormal = { fg = "#EDEDED", bg = "#1A1A1A" },
					TelescopeBorder = { fg = "#5C78FF", bg = "#1A1A1A" },
					TelescopeSelection = { fg = "#1A1A1A", bg = "#FFD7AF", bold = true },
					TelescopeSelectionCaret = { fg = "#FFD700", bg = "#FFD7AF" },
				}
			end,
			integrations = {
				gitsigns = true,
				nvimtree = true,
				blink_cmp = true,
				treesitter = true,
				harpoon = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				which_key = true,
			},
		})
	end,
}
