vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/meuter/lualine-so-fancy.nvim",
})

require("lualine").setup({
    options = { theme = "tokyonight" },
    sections = {
        lualine_a = {
            { "mode" },
            { "fancy_macro" },
        },
    },
})
