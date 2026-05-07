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
					Visual = { fg = "#1A1A1A", bg = "#FFD7AF" },
					VisualNOS = { fg = "#1A1A1A", bg = "#FFD7AF" },
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

					-- Syntax (legacy groups)
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

					-- Treesitter groups
					["@comment"] = { fg = "#9E9E9E", italic = true },
					["@string"] = { fg = "#98C379" },
					["@string.escape"] = { fg = "#62CFF3" },
					["@character"] = { fg = "#98C379" },
					["@number"] = { fg = "#E5C07B" },
					["@float"] = { fg = "#E5C07B" },
					["@boolean"] = { fg = "#FF6C75" },
					["@constant"] = { fg = "#E5C07B" },
					["@constant.builtin"] = { fg = "#FF6C75" },
					["@function"] = { fg = "#61AFEF", bold = true },
					["@function.call"] = { fg = "#61AFEF" },
					["@function.builtin"] = { fg = "#62CFF3" },
					["@method"] = { fg = "#61AFEF", bold = true },
					["@method.call"] = { fg = "#61AFEF" },
					["@keyword"] = { fg = "#C678DD", italic = true },
					["@keyword.return"] = { fg = "#C678DD", italic = true },
					["@keyword.operator"] = { fg = "#FFD700" },
					["@conditional"] = { fg = "#C678DD", italic = true },
					["@repeat"] = { fg = "#C678DD", italic = true },
					["@include"] = { fg = "#C678DD", italic = true },
					["@exception"] = { fg = "#E06C75" },
					["@operator"] = { fg = "#FFD700" },
					["@type"] = { fg = "#56B6C2" },
					["@type.builtin"] = { fg = "#56B6C2", italic = true },
					["@variable"] = { fg = "#EDEDED" },
					["@variable.builtin"] = { fg = "#FF6C75" },
					["@parameter"] = { fg = "#EDEDED" },
					["@field"] = { fg = "#61AFEF" },
					["@property"] = { fg = "#61AFEF" },
					["@namespace"] = { fg = "#E5C07B" },
					["@punctuation.delimiter"] = { fg = "#ABB2BF" },
					["@punctuation.bracket"] = { fg = "#ABB2BF" },
					["@tag"] = { fg = "#E06C75" },
					["@tag.attribute"] = { fg = "#E5C07B" },

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

					-- Diff (visible colored backgrounds)
					DiffAdd = { bg = "#1E3A1E" },
					DiffChange = { bg = "#2A2A1A" },
					DiffDelete = { bg = "#3A1E1E" },
					DiffText = { fg = "#FFD700", bg = "#3A3A1A", bold = true },

					-- Blink signature help active parameter
					BlinkCmpSignatureHelpActiveParameter = { fg = "#1A1A1A", bg = "#FFD700", bold = true },

					-- Snippet active tabstop (shown when accepting completions with brackets)
					SnippetTabstopActive = { fg = "#FFD700", bold = true },

					-- LSP highlights
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
