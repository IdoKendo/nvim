return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            ui.setup({
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        disconnect = "",
                        pause = "",
                        play = "",
                        run_last = "",
                        step_back = "",
                        step_into = "",
                        step_out = "",
                        step_over = "",
                        terminate = "",
                    },
                },
                element_mappings = {},
                expand_lines = true,
                floating = {
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                force_buffers = true,
                icons = {
                    collapsed = "",
                    current_frame = "",
                    expanded = "",
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.5 },
                            { id = "watches", size = 0.5 },
                        },
                        size = 40,
                        position = "right",
                    },
                    {
                        elements = { "repl" },
                        size = 10,
                        position = "bottom",
                    },
                },
                mappings = {
                    edit = "e",
                    expand = { "<CR>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t",
                },
                render = {
                    indent = 2,
                    max_value_lines = 100,
                },
            })
            require("nvim-dap-virtual-text").setup({
                virt_lines = false,
                virt_text_pos = "eol",
            })

            dap.set_log_level("DEBUG")

            vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

            vim.keymap.set("n", "<leader>rc", dap.continue, { desc = "[R]un [C]ontinue" })
            vim.keymap.set("n", "<leader>rs", dap.step_over, { desc = "[R]un [S]tep Over" })
            vim.keymap.set("n", "<leader>ri", dap.step_into, { desc = "[R]un Step [I]nto" })
            vim.keymap.set("n", "<leader>ro", dap.step_out, { desc = "[R]un Step [O]ut" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
            vim.keymap.set("n", "<leader>rb", dap.run_to_cursor, { desc = "[R]un to cursor and [B]reakpoint" })
            vim.keymap.set("n", "<leader>re", ui.eval, { desc = "[R]un [E]val" })
            vim.keymap.set("n", "<leader>rk", dap.terminate, { desc = "[R]un [K]ill" })
            vim.keymap.set("n", "<leader>rT", ui.toggle, { desc = "[R]un [T]oggle UI" })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap_python = require("dap-python")
            dap_python.setup("~/personal/debugpy/.venv/bin/python")
            dap_python.test_runner = "pytest"
            table.insert(require("dap").configurations.python, {
                name = "Debug test",
                type = "python",
                request = "launch",
                module = "pytest",
                args = {
                    "${file}",
                    "-sv",
                    "--log-cli-level=INFO",
                    "--log-file=test_out.log",
                },
                console = "integratedTerminal",
            })
        end,
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap_go = require("dap-go")
            dap_go.setup({
                delve = {
                    build_flags = { "-tags=cloud" },
                },
            })
            vim.keymap.set("n", "<leader>rt", dap_go.debug_test, { desc = "[R]un [T]est" })
        end,
    },
}
