return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "rcarriga/cmp-dap",
        },
        version = "1.*",
        opts = {
            keymap = {
                preset = "enter",
                ["<C-j>"] = { "select_next" },
                ["<C-k>"] = { "select_prev" },
            },

            enabled = function()
                local cmp_dap = require("cmp_dap")
                return vim.bo.buftype ~= "prompt" or cmp_dap.is_dap_buffer()
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
        },
        opts_extend = { "sources.default" },
    },
}
