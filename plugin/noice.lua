vim.pack.add({
    "https://github.com/folke/noice.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/rcarriga/nvim-notify",
})

vim.keymap.set({ "n", "v", "i" }, "<leader>nm", ":Noice<CR>", { desc = "[N]oice [M]essages" })
vim.keymap.set({ "n", "v", "i" }, "<leader>nd", ":NoiceDismiss<CR>", { desc = "[N]oice [D]ismiss" })

require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
})

require("notify").setup({
    background_colour = "#000000",
})
