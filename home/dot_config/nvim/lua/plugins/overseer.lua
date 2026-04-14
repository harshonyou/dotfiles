local GLOBAL_VENV = "/Users/aei/.poetry-global/.venv"

local function resolve_python()
	local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
	if vim.fn.filereadable(venv_python) == 1 then
		return venv_python
	end
	local global_python = GLOBAL_VENV .. "/bin/python"
	if vim.fn.filereadable(global_python) == 1 then
		return global_python
	end
	return "python3"
end

local function resolve_pytest()
	local cwd = vim.fn.getcwd()
	local venv_pytest = cwd .. "/.venv/bin/pytest"
	if vim.fn.filereadable(venv_pytest) == 1 then
		return { venv_pytest, "-v" }
	end
	local venv_python = cwd .. "/.venv/bin/python"
	if vim.fn.filereadable(venv_python) == 1 then
		return { venv_python, "-m", "pytest", "-v" }
	end
	local global_pytest = GLOBAL_VENV .. "/bin/pytest"
	if vim.fn.filereadable(global_pytest) == 1 then
		return { global_pytest, "-v" }
	end
	return { GLOBAL_VENV .. "/bin/python", "-m", "pytest", "-v" }
end

return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen" },
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<CR>", desc = "Overseer: Run task" },
		{ "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Overseer: Toggle task list" },
		{ "<leader>oo", "<cmd>OverseerOpen<CR>", desc = "Overseer: Open task list" },
	},
	opts = {
		templates = { "builtin" },
		task_list = {
			direction = "bottom",
			min_height = 15,
			max_height = 20,
			bindings = {
				["<CR>"] = "RunAction",
				["q"] = "Close",
			},
		},
		component_aliases = {
			default = {
				{ "display_duration", detail_level = 2 },
				"on_output_summarize",
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- Python template: run current file
		overseer.register_template({
			name = "Python: run file",
			builder = function()
				return {
					cmd = { resolve_python(), vim.fn.expand("%:p") },
					components = { "default", "on_output_quickfix", "open_output" },
				}
			end,
			condition = { filetype = { "python" } },
		})

		-- Python template: run file interactively (-i stays in REPL after run)
		overseer.register_template({
			name = "Python: run file (interactive)",
			builder = function()
				vim.api.nvim_create_autocmd("TermOpen", {
					once = true,
					callback = function(ev)
						vim.defer_fn(function()
							overseer.open({ enter = false })
							local winid = vim.fn.bufwinid(ev.buf)
							if winid ~= -1 then
								vim.api.nvim_set_current_win(winid)
								vim.cmd("startinsert")
							end
						end, 100)
					end,
				})
				return {
					cmd = { resolve_python(), "-i", vim.fn.expand("%:p") },
					components = { "default", "open_output" },
					stdin = true,
				}
			end,
			condition = { filetype = { "python" } },
		})

		-- Python template: run pytest
		overseer.register_template({
			name = "Python: pytest",
			builder = function()
				return {
					cmd = resolve_pytest(),
					components = { "default", "on_output_quickfix", "open_output" },
				}
			end,
			condition = { filetype = { "python" } },
		})
	end,
}
