vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", function()
    require("undotree").open({ command = "topleft 35vnew" })
end, { desc = "Toggle [U]ndo tree" })
