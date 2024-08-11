return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    keys = {
        { "<leader>sc", ":Silicon<CR>", mode = "v", desc = "[S]napshot [C]ode" },
    },
    config = function()
        require("silicon").setup({
            -- font = "FiraCode Nerd Font Mono=34;Noto Emoji=34", -- TODO: why did this stop working?
            no_line_number = true,
            theme = "tokyonight_night",
            window_title = function()
                return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
            end,
        })
    end,
}
