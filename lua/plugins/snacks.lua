return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
        gitbrowse = {},
    },
    config = function()
        require("config.snacks")
    end,
}
