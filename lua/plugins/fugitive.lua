return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "[G]it [S]how" },
        { "<leader>ga", '<cmd>Gwrite<CR>', desc = "[G]it [A]dd" },
        { "<leader>gd", '<cmd>Gvdiff<CR>', desc = "[G]it [D]iff" },
        { "<leader>gb", '<cmd>Git blame<CR>', desc = "[G]it [B]lame" }
    },
}
