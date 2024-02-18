return {
    {
        "folke/zen-mode.nvim",
        dependencies = {
            { "folke/twilight.nvim", lazy = true },
        },
        keys = {
            {
                "<leader>zm",
                function()
                    require("zen-mode").toggle({
                        window = {
                            width = 0.9,
                        },
                    })
                end,
                desc = "[Z]en [M]ode",
            },
        },
        opts = {
            window = {
                options = {
                    colorcolumn = "",
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
                },
            },
            plugins = {
                gitsigns = { enabled = true },
                tmux = { enabled = true },
            },
        },
    },
}
