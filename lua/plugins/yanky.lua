return {
    "gbprod/yanky.nvim",
    keys = {
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "[P]aste after" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "[P]aste before" },
        { "<C-n>", "<Plug>(YankyCycleForward)", desc = "Cycle forward paste" },
        { "<C-m>", "<Plug>(YankyCycleBackward)", desc = "Cycle backward paste" },
        {
            "<leader>hp",
            function()
                require("telescope").extensions.yank_history.yank_history()
            end,
            desc = "[H]istory [P]aste",
        },
    },
    config = function()
        require("yanky").setup()
    end,
}
