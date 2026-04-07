vim.pack.add({ "https://github.com/cbochs/grapple.nvim" })

require("grapple").setup({
    scope = "git",
})

vim.keymap.set("n", "<leader>a", "<cmd>Grapple toggle<cr>", { desc = "[A]dd to Grapple" })
vim.keymap.set("n", "<C-e>", "<cmd>Grapple toggle_tags<cr>", { desc = "Toggle tags menu" })
vim.keymap.set("n", "<C-t>", "<cmd>Grapple select index=1<cr>", { desc = "Select first tag" })
vim.keymap.set("n", "<C-y>", "<cmd>Grapple select index=2<cr>", { desc = "Select second tag" })
