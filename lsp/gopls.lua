return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                ST1000 = false,
                ST1003 = false,
            },
            staticcheck = true,
            buildFlags = { "-tags=cloud" },
        },
    },
}
