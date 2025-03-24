return {
    "aaronik/treewalker.nvim",
    opts = {
        highlight = true,
        highlight_duration = 500,
        highlight_group = "CursorLine",
    },
    keys = {
        { "<leader>wk", "<cmd>Treewalker Up<cr>", mode = { "n", "v" }, desc = "[W]alk [K]" },
        { "<leader>wj", "<cmd>Treewalker Down<cr>", mode = { "n", "v" }, desc = "[W]alk [J]" },
        { "<leader>wh", "<cmd>Treewalker Left<cr>", mode = { "n", "v" }, desc = "[W]alk [H]" },
        { "<leader>wl", "<cmd>Treewalker Right<cr>", mode = { "n", "v" }, desc = "[W]alk [L]" },
        { "<leader>sk", "<cmd>Treewalker SwapUp<cr>", mode = { "n", "v" }, desc = "[S]wap [K]" },
        { "<leader>sj", "<cmd>Treewalker SwapDown<cr>", mode = { "n", "v" }, desc = "[S]wap [J]" },
        { "<leader>sh", "<cmd>Treewalker SwapLeft<cr>", mode = { "n", "v" }, desc = "[S]wap [H]" },
        { "<leader>sl", "<cmd>Treewalker SwapRight<cr>", mode = { "n", "v" }, desc = "[S]wap [L]" },
    },
}
