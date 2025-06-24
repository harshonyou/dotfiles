return {
	"b0o/incline.nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "VeryLazy",
	config = function()
		local mini_icons = require("mini.icons")

		local function get_fg_from_hl(hl_group)
			local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_group })
			if ok and hl_def.fg then
				return string.format("#%06x", hl_def.fg)
			end
			return "#aaaaaa"
		end

		require("incline").setup({
			hide = {
				only_win = false,
			},
			render = function(props)
				local buf = props.buf
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end

				local icon, hl_group = mini_icons.get("file", filename)
				local icon_color = hl_group and get_fg_from_hl(hl_group) or "#aaaaaa"

				local modified = vim.bo[props.buf].modified

				-- modified and { " [+]", guifg = "#ff9e64" } or "",
				return {
					{ icon .. " ", guifg = icon_color },
					{ filename, gui = modified and "bold" or "none" },
					modified and { "[+]", guifg = "#ff9e64" } or "",
				}
			end,
		})
	end,
}
