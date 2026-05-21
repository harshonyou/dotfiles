return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"c",
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"python",
			"markdown",
			"markdown_inline",
			"go",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python", "markdown", "go" },
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter.indent'.get_indent(v:lnum)"
			end,
		})

		-- Incremental AST selection (module removed from nvim-treesitter main)
		local _ts_sel_stack = {}

		local function ts_node_select(node)
			local sr, sc, er, ec = node:range()
			if ec == 0 then
				er = er - 1
				local line = vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] or ""
				ec = math.max(0, #line - 1)
			else
				ec = ec - 1
			end
			vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { er + 1, ec })
		end

		vim.keymap.set("n", "<CR>", function()
			_ts_sel_stack = {}
			local node = vim.treesitter.get_node()
			if not node then return end
			_ts_sel_stack[1] = node
			ts_node_select(node)
		end)

		vim.keymap.set("x", "<CR>", function()
			local cur = _ts_sel_stack[#_ts_sel_stack]
			if not cur then return end
			local parent = cur:parent()
			if not parent then return end
			table.insert(_ts_sel_stack, parent)
			local node = parent
			vim.schedule(function() ts_node_select(node) end)
			return vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		end, { expr = true })

		vim.keymap.set("x", "<BS>", function()
			if #_ts_sel_stack <= 1 then return end
			table.remove(_ts_sel_stack)
			local node = _ts_sel_stack[#_ts_sel_stack]
			vim.schedule(function() ts_node_select(node) end)
			return vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		end, { expr = true })
	end,
}
