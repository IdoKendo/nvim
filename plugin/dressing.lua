vim.pack.add({ "https://github.com/stevearc/dressing.nvim" })

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
