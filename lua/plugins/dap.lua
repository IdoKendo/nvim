return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            ui.setup()
            require("nvim-dap-virtual-text").setup({})

            dap.set_log_level("DEBUG")

            vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

            vim.keymap.set("n", "<leader>rc", dap.continue, { desc = "[R]un [C]ontinue" })
            vim.keymap.set("n", "<leader>rs", dap.step_over, { desc = "[R]un [S]tep Over" })
            vim.keymap.set("n", "<leader>ri", dap.step_into, { desc = "[R]un Step [I]nto" })
            vim.keymap.set("n", "<leader>ro", dap.step_out, { desc = "[R]un Step [O]ut" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
            vim.keymap.set("n", "<leader>rb", dap.run_to_cursor, { desc = "[R]un to cursor and [B]reakpoint" })
            vim.keymap.set("n", "<leader>rr", dap.repl.toggle, { desc = "[R]un [R]epl" })
            vim.keymap.set("n", "<leader>rk", dap.terminate, { desc = "[R]un [K]ill" })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = "mfussenegger/nvim-dap",
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
}
