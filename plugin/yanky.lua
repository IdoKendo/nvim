vim.pack.add({ "https://github.com/gbprod/yanky.nvim" })

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "[P]aste after" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "[P]aste before" })
vim.keymap.set({ "n" }, "<C-n>", "<Plug>(YankyCycleForward)", { desc = "Cycle forward paste" })
vim.keymap.set({ "n" }, "<C-p>", "<Plug>(YankyCycleBackward)", { desc = "Cycle backward paste" })
vim.keymap.set({ "n" }, "<leader>hp", function()
    require("telescope").extensions.yank_history.yank_history()
end, {
    desc = "[H]istory [P]aste",
})

require("yanky").setup()
