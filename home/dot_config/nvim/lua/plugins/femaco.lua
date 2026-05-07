return {
	"AckslD/nvim-FeMaco.lua",
	config = function()
		require("femaco").setup({
			ft_from_lang = function(lang)
				local map = {
					py = "python",
					sh = "bash",
					js = "javascript",
					ts = "typescript",
					html = "html",
					md = "markdown",
					rb = "ruby",
				}
				return map[lang] or lang
			end,

			ensure_newline = function(base_filetype)
				return base_filetype == "markdown"
			end,

			post_open_float = function(winnr)
				vim.wo.signcolumn = "no"

				-- Defer so buffer is ready
				vim.defer_fn(function()
					local ft = vim.bo.filetype
					if ft == "python" then
						-- Visual selection: run all
						vim.keymap.set(
							"v",
							"<leader>rr",
							":SnipRun<CR>",
							{ buffer = true, desc = "Run block with SnipRun" }
						)
						-- Normal mode: run current line (less useful without REPL)
						vim.keymap.set(
							"n",
							"<leader>rl",
							":SnipRun<CR>",
							{ buffer = true, desc = "Run line with SnipRun" }
						)
						-- Normal mode: run full buffer
						vim.keymap.set(
							"n",
							"<leader>ra",
							"ggVG:SnipRun<CR>",
							{ buffer = true, desc = "Run all with SnipRun" }
						)

						-- Optional: auto-run on save
						vim.api.nvim_create_autocmd("BufWritePost", {
							buffer = 0,
							callback = function()
								vim.cmd("SnipRun")
							end,
						})
					end
				end, 50)
			end,
		})
	end,
	ft = { "markdown" },
	cmd = { "Femaco" },
	keys = {
		{ "<leader>pe", "<cmd>FeMaco<cr>", desc = "FeMaco preview" },
	},
	-- module = { "femaco_edit" },
	-- disable = true,
}
