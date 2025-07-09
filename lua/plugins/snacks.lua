return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
        gitbrowse = {},
        picker = {
            sources = {
                select = {
                    layout = {
                        preset = "telescope",
                    },
                },
            },
        },
    },
    config = function()
        require("config.snacks")
    end,
}
