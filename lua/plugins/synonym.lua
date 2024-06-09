return {
    "IdoKendo/synonym.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        {
            "<leader>vrs",
            function()
                require("synonym").find_synonym()
            end,
            desc = "[V]isual [R]ename [S]ynonym",
        },
    },
}
