return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gg", vim.cmd.Git, desc = "[G]it [G]it" },
        { "<leader>ga", "<cmd>Gwrite<CR>", desc = "[G]it [A]dd" },
        { "<leader>gd", "<cmd>Gvdiff<CR>", desc = "[G]it [D]iff" },
        { "<leader>gb", "<cmd>Git blame<CR>", desc = "[G]it [B]lame" },
    },
}
