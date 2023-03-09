vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>ga", ':Gwrite<CR>', {noremap = true, silent = true})
vim.keymap.set("n", "<leader>gb", ':Git blame<CR>', {noremap = true, silent = true})

