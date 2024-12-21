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
            require("config.dap")
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
            table.insert(require("dap").configurations.python, {
                name = "Debug code",
                type = "python",
                request = "launch",
                cwd = vim.fn.getcwd() .. "/src",
                program = "${file}",
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
