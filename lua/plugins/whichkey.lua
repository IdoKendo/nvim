return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Which Key[?]",
        },
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.setup()
        wk.add({
            { "<leader>d", group = "[D]iagnostics" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>h", group = "[H]istory" },
            { "<leader>l", group = "[L]oad" },
            { "<leader>m", group = "[M]ake" },
            { "<leader>n", group = "[N]oice" },
            { "<leader>o", group = "[O]bsidian" },
            { "<leader>p", group = "[P]retty" },
            { "<leader>r", group = "[R]un" },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>w", group = "[W]alk" },
        })
    end,
}
