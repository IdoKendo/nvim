return {
    "lewis6991/gitsigns.nvim",
    keys = {
        { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "[G]it [T]oggle blame" }
    },
    config = function()
        require("gitsigns").setup()
    end
}
