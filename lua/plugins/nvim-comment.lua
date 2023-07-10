return {
    "terrortylor/nvim-comment",
    config = function()
        require("nvim_comment").setup()
    end,
    keys = {
        { "<leader>cc", ":CommentToggle<CR>", desc = "[C]omment [C]ode" },
        { "<leader>cc", ":'<,'>CommentToggle<CR>", mode = "v", desc = "[C]omment [C]ode" },
    },
}
