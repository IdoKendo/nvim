return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        { "nvim-telescope/telescope.nvim" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("git_worktree")

        vim.keymap.set("n", "<leader>wtt", function()
            telescope.extensions.git_worktree.git_worktrees()
        end, { desc = "[W]ork [T]rees [T]elescope" })

        vim.keymap.set("n", "<leader>wta", function()
            telescope.extensions.git_worktree.create_git_worktree()
        end, { desc = "[W]ork [T]rees [A]dd" })
    end,
}
