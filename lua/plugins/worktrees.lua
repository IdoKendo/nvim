return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        { "nvim-telescope/telescope.nvim" },
    },
    config = function()
        local worktree = require("git-worktree")
        local telescope = require("telescope")
        worktree.setup({})
        telescope.load_extension("git_worktree")

        local function set_gowork_for_path(path)
            local gopls_clients = vim.lsp.get_clients({ name = "gopls" })
            if #gopls_clients == 0 then
                return
            end

            local go_work = vim.fs.find("go.work", { path = path, upward = true })[1]
            if go_work then
                vim.env.GOWORK = vim.fs.normalize(go_work)
                return
            end

            vim.env.GOWORK = "off"
        end

        local function restart_lsp_clients()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            vim.lsp.stop_client(clients)
            vim.cmd.update()
            vim.defer_fn(vim.cmd.edit, 1000)
        end

        worktree.on_tree_change(function(op, metadata)
            if op ~= worktree.Operations.Switch and op ~= worktree.Operations.Create then
                return
            end

            local path = metadata and metadata.path
            if not path or path == "" then
                path = vim.uv.cwd()
            end

            set_gowork_for_path(path)
            restart_lsp_clients()
        end)

        vim.keymap.set("n", "<leader>wtt", function()
            telescope.extensions.git_worktree.git_worktrees()
        end, { desc = "[W]ork [T]rees [T]elescope" })

        vim.keymap.set("n", "<leader>wta", function()
            telescope.extensions.git_worktree.create_git_worktree()
        end, { desc = "[W]ork [T]rees [A]dd" })
    end,
}
