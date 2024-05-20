return {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "reorder-python-imports" },
                sql = { "sqlfmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        })

        conform.formatters.sqlfmt = {
            prepend_args = { "-l", "120" },
        }

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 5000,
            })
        end, { desc = "[M]ake [P]retty" })
    end,
}
