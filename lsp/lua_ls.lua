return {
    filetypes = { "lua" },
    settings = {
        lua = {
            runtime = {
                version = "luajit",
            },
            completion = {
                callsnippet = "replace",
            },
            diagnostics = {
                globals = { "vim", "require" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}
