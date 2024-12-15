return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "meuter/lualine-so-fancy.nvim",
    },
    config = function()
        require("lualine").setup({
            options = { theme = "tokyonight" },
            sections = {
                lualine_a = {
                    { "mode" },
                    { "fancy_macro" },
                },
            },
        })
    end,
}
