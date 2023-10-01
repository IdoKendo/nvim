return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.setup()
        wk.register({
            ["<leader>"] = {
                c = {
                    name = "[C]omment",
                },
                d = {
                    name = "[D]iagnostics",
                },
                e = {
                    name = "Troubl[E]",
                },
                f = {
                    name = "[F]ind",
                },
                g = {
                    name = "[G]it",
                },
                o = {
                    name = "[O]bsidian",
                },
                r = {
                    name = "[R]un",
                },
                t = {
                    name = "[T]est",
                },
                v = {
                    name = "[V]iew",
                },
            },
        })
    end,
}
