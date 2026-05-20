return {
    "ahmedkhalf/project.nvim",
    pin = true, -- local patch for nvim 0.12 vim.lsp.get_clients API change, remove when upstream fixes
    init = function()
        -- project.nvim uses removed vim.lsp.buf_get_clients() — patch until upstream fixes it
        if vim.lsp.buf_get_clients == nil then
            vim.lsp.buf_get_clients = function(bufnr)
                return vim.lsp.get_clients({ bufnr = bufnr or 0 })
            end
        end

        require("project_nvim").setup {
            -- Automatically detect project root and cd to it
            manual_mode = false,

            -- Detection methods in order of priority
            detection_methods = { "lsp", "pattern" },

            -- Patterns to detect project root
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "CMakeLists.txt", "package.json", "Cargo.toml" },

            -- Automatically change directory when opening a file
            silent_chdir = true,

            -- Show hidden files in telescope
            show_hidden = false,

            -- Don't use home directory as project root
            scope_chdir = "global",

            -- Path to store project history
            datapath = vim.fn.stdpath("data"),
        }


        -- Absolutely minimal implementation of fzf-lua based project finder
        -- for fzf-lua, due to request from @KrisWilliams1 (Maybe extended to a
        -- full blown port from the original selector in the future)
        local history = require("project_nvim.utils.history")
        local project = require("project_nvim.project")

        vim.api.nvim_create_user_command("FzfProjects", function()
            local projects = history.get_recent_projects()

            require("fzf-lua").fzf_exec(projects, {
                prompt = "Projects> ",
                actions = {
                    ["default"] = function(selected)
                        if selected and #selected > 0 then
                            local project_path = selected[1]
                            if project.set_pwd(project_path, "fzf-lua") then
                                require("fzf-lua").files()
                            end
                        end
                    end
                }
            })
        end, {})
    end,
    keys = {
        {
            "<leader>fp", "<cmd>FzfProjects<CR>", desc="Find Recent Projects"
        }
    }
}
