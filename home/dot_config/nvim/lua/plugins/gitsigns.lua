return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		update_debounce = 100,
		status_formatter = nil, -- Use default
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		-- yadm = {
		-- 	enable = false,
		-- },
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "<leader>gn", gs.next_hunk, "Next Hunk")
			map("n", "<leader>gN", gs.prev_hunk, "Prev Hunk")

			-- Actions
			map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")

			map("v", "<leader>gs", function() -- stage selected hunk
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk")
			map("v", "<leader>gr", function() -- reset selected hunk
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk")

			map("n", "<leader>gS", gs.stage_buffer, "Stage buffer") -- stage whole buffer
			map("n", "<leader>gR", gs.reset_buffer_index, "Reset buffer") -- unstage whole buffer

			map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")

			map("n", "<leader>gbl", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")

			map("n", "<leader>gd", gs.diffthis, "Diff this")
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, "Diff this ~")

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
		end,
	},
}
