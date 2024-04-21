return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gg", vim.cmd.Git, desc = "[G]it [G]it" },
        { "<leader>ga", vim.cmd.Gwrite, desc = "[G]it [A]dd" },
        { "<leader>gb", "<cmd>Git blame<CR>", desc = "[G]it [B]lame" },
        { "<leader>gc", "<cmd>Git commit<CR>", desc = "[G]it [C]ommit" },
        { "<leader>gd", vim.cmd.Gvdiff, desc = "[G]it [D]iff" },
        { "<leader>gp", "<cmd>Git push<CR>", desc = "[G]it [P]ush" },
    },
}
