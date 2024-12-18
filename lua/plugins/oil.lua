return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        { "<leader>fv", "<cmd>Oil<CR>", desc = "[F]ile [V]iewer" },
    },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
