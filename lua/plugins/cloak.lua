return {
    "laytan/cloak.nvim",
    config = function()
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
        vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", { desc = "[C]loak [T]oggle" })
    end,
}
