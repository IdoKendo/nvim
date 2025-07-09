return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("dressing").setup({
            select = {
                get_config = function(opts)
                    if opts.kind == "codeaction" then
                        return {
                            backend = "builtin",
                        }
                    end
                end,
            },
        })
    end,
}
