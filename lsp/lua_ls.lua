return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim", "require" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    "${3rd}/luv/library",
                },
            },
        },
    },
}
