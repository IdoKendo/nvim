vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

vim.keymap.set({ "n" }, "<leader>gg", vim.cmd.Git, { desc = "[G]it [G]it" })
vim.keymap.set({ "n" }, "<leader>ga", vim.cmd.Gwrite, { desc = "[G]it [A]dd" })
vim.keymap.set({ "n" }, "<leader>gb", "<cmd>Git blame<CR>", { desc = "[G]it [B]lame" })
vim.keymap.set({ "n" }, "<leader>gc", "<cmd>Git commit<CR>", { desc = "[G]it [C]ommit" })
vim.keymap.set({ "n" }, "<leader>gd", ":Gdiffsplit!<CR>", { desc = "[G]it [D]iff" })
vim.keymap.set({ "n" }, "<leader>gp", "<cmd>Git push<CR>", { desc = "[G]it [P]ush" })
vim.keymap.set({ "n" }, "<leader>gl", "<cmd>Git pull<CR>", { desc = "[G]it pul[L]" })
