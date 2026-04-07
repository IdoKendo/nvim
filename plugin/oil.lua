vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

vim.keymap.set("n", "<leader>fv", "<cmd>Oil<CR>", { desc = "[F]ile [V]iewer" })

require("oil").setup({
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-d>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-r>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    use_default_keymaps = false,
    view_options = {
        show_hidden = true,
    },
})
