return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    keys = {
        { "<leader>sc", ":Silicon<CR>", mode = "v", desc = "[S]napshot [C]ode" },
    },
    config = function()
        require("nvim-silicon").setup({
            no_line_number = true,
            window_title = function()
                return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
            end,
        })
    end,
}
