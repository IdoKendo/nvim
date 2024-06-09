return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.setup()
        wk.register({
            ["<leader>"] = {
                c = { name = "[C]omment" },
                d = { name = "[D]iagnostics" },
                f = { name = "[F]ind" },
                g = { name = "[G]it" },
                h = { name = "[H]istory" },
                l = { name = "[L]oad" },
                m = { name = "[M]ake" },
                o = { name = "[O]bsidian" },
                p = { name = "[P]retty" },
                r = { name = "[R]un" },
                t = { name = "[T]est" },
                v = { name = "[V]iew" },
            },
        })
    end,
}
