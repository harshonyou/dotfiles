return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2", -- Important! This is the new version
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
	},
	config = function()
		local harpoon = require("harpoon")
		local fzf = require("fzf-lua")

		-- local function get_project_key()
		-- 	local project = require("project_nvim.project")
		-- 	local root = project.get_project_root()
		--
		-- 	-- fallback to cwd if project root not found
		-- 	if not root then
		-- 		root = vim.fn.getcwd()
		-- 	end
		--
		-- 	return root
		-- end
		--
		-- local function get_project_list()
		-- 	return harpoon:list(get_project_key())
		-- end

		local list = require("harpoon"):list()

		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		local function harpoon_fzf_picker()
			local entries = {}

			for i = 1, list:length() do
				local item = list:get(i)
				if item then
					table.insert(entries, item.value)
				end
			end

			fzf.fzf_exec(entries, {
				prompt = "Harpoon Files> ",
				actions = {
					["default"] = function(selected)
						vim.cmd("edit " .. selected[1])
					end,
				},
			})
		end

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>a", function()
			list:add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-c>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- --Harpoon marked files
		-- vim.keymap.set("n", "<C-a>", function()
		-- 	harpoon:list():select(1)
		-- end)
		-- vim.keymap.set("n", "<C-r>", function()
		-- 	harpoon:list():select(2)
		-- end)
		-- vim.keymap.set("n", "<C-s>", function()
		-- 	harpoon:list():select(3)
		-- end)
		-- vim.keymap.set("n", "<C-t>", function()
		-- 	harpoon:list():select(4)
		-- end)

		for i = 1, 5 do
			vim.keymap.set("n", "<leader>" .. i, function()
				list:select(i)
			end, { desc = "Harpoon go to file " .. i })
		end

		vim.keymap.set("n", "<leader>fh", harpoon_fzf_picker, { desc = "Fzf Harpoon Files" })
	end,
}
