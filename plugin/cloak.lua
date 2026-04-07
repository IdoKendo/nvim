vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/laytan/cloak.nvim" })

        vim.keymap.set("n", "<leader>tc", "<cmd>CloakToggle<CR>", { desc = "[T]oggle [C]loak" })

        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            cloak_length = 8,
            try_all_patterns = true,
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                        "credentials",
                    },
                    cloak_pattern = "=.+",
                    replace = nil,
                },
                {
                    file_pattern = {
                        "*.hurl",
                    },
                    cloak_pattern = {
                        "(Authorization: Bearer).+",
                    },
                    replace = nil,
                },
            },
        })
    end,
})
