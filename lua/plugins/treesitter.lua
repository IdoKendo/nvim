return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["ac"] = "@call.outer",
                            ["ic"] = "@call.inner",
                        },
                    },
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
            { "<leader>ttp", ":TSPlaygroundToggle<CR>", desc = "[T]oggle [T]reesitter [P]layground" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context", -- sticky function definition
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        keys = {
            { "<leader>ttc", ":TSContext toggle<CR>", desc = "[T]oggle [T]reesitter [C]ontext" },
        },
        config = function()
            vim.cmd(":TSContext enable")
        end,
    },
}
