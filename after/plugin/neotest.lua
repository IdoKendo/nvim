local neotest = require("neotest")

vim.keymap.set("n", "<F9>", function() neotest.run.run() end, opts)
vim.keymap.set("n", "<leader>tr", function() neotest.output_panel.toggle() end, opts)

neotest.setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = ".venv/bin/python",
        })
    }
})


