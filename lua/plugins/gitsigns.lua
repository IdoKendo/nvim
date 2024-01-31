return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        { "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", desc = "[G]it [T]oggle blame" },
        { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "[G]it [P]review" },
    },
    config = function()
        require("gitsigns").setup()
    end,
}
