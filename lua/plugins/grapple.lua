return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git",
    },
    keys = {
        { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "[A]dd to Grapple" },
        { "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
        { "<C-t>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
        { "<C-y>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    },
}
