vim.pack.add({ "https://github.com/michaelrommel/nvim-silicon" })

vim.keymap.set({ "v" }, "<leader>sc", ":Silicon<CR>", { desc = "[S]napshot [C]ode" })

require("nvim-silicon").setup({
    no_line_number = true,
    window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
    end,
})
