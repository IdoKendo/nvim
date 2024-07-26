return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
            vim.filetype.add({
                extension = {
                    templ = "templ",
                },
            })
        end,
    },
    {
        "nvim-treesitter/playground",
        keys = {
            { "<leader>vt", ":TSPlaygroundToggle<CR>", desc = "[V]iew [T]reesitter" },
        },
    },
    "nvim-treesitter/nvim-treesitter-context", -- sticky function definition
}
