local dap = require("dap")
local dapui = require("dapui")
local dappython = require("dap-python")

dappython.setup("~/.virtualenvs/debugpy/bin/python")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.set_log_level("DEBUG")

vim.fn.sign_define('DapBreakpoint',{ text ='🔴', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', function() dapui.toggle() end)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)

