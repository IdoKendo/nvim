return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        gitbrowse = {},
    },
    config = function()
        require("config.snacks")
    end,
}
