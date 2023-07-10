return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "[G]it [S]how" },
        { "<leader>ga", ':Gwrite<CR>', desc = "[G]it [A]dd" },
        { "<leader>gb", ':Git blame<CR>', desc = "[G]it [B]lame" }
    },
}
