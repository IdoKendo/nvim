return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.set_log_level("DEBUG")

            vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

            vim.keymap.set("n", "<leader>rc", dap.continue, { desc = "[R]un [C]ontinue" })
            vim.keymap.set("n", "<leader>rs", dap.step_over, { desc = "[R]un [S]tep Over" })
            vim.keymap.set("n", "<leader>ri", dap.step_into, { desc = "[R]un Step [I]nto" })
            vim.keymap.set("n", "<leader>ro", dap.step_out, { desc = "[R]un Step [O]ut" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
            vim.keymap.set("n", "<leader>rr", dap.repl.toggle, { desc = "[R]un [R]epl" })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
            require("dap-python").setup("~/.local/share/pyenv/versions/3.11.5/envs/debugpy/bin/python")
        end,
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap_go = require("dap-go")
            dap_go.setup()
            vim.keymap.set("n", "<leader>rt", dap_go.debug_test, { desc = "[R]un [T]est" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dapui = require("dapui")

            dapui.setup()

            require("dap").listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            vim.keymap.set("n", "<leader>ru", function()
                dapui.toggle()
            end, { desc = "[R]un [U]I" })
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
}
