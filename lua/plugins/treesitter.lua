return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
        end
    },
    {
        "nvim-treesitter/playground",
        keys = {
            { "<leader>vt", ":TSPlaygroundToggle<CR>", desc = "[V]iew [T]reesitter" },
        },
    },
    "nvim-treesitter/nvim-treesitter-context",
}
