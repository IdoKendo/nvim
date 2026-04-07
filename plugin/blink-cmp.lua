vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.pack.add({
            {
                src = "https://github.com/saghen/blink.compat",
                version = vim.version.range(">=0.0.0"),
            },
            "https://github.com/rafamadriz/friendly-snippets",
            "https://github.com/mfussenegger/nvim-dap",
            "https://github.com/rcarriga/cmp-dap",
            {
                src = "https://github.com/saghen/blink.cmp",
                version = vim.version.range(">=1.0.0 <2.0.0"),
            },
        })

        require("blink.compat").setup({})

        require("blink.cmp").setup({
            keymap = {
                preset = "enter",
                ["<C-j>"] = { "select_next" },
                ["<C-k>"] = { "select_prev" },
            },

            enabled = function()
                local ok, cmp_dap = pcall(require, "cmp_dap")
                local is_dap_buffer = ok and type(cmp_dap.is_dap_buffer) == "function" and cmp_dap.is_dap_buffer()
                return vim.bo.buftype ~= "prompt" or is_dap_buffer
            end,

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = { auto_show = true },
                menu = {
                    border = "rounded",
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind" },
                        },
                    },
                },
            },

            signature = {
                enabled = true,
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    sql = { "snippets", "dadbod" },
                },
                providers = {
                    dadbod = { name = "dadbod", module = "vim_dadbod_completion.blink" },
                    dap = { name = "dap", module = "blink.compat.source" },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        })
    end,
})
