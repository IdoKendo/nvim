return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    on_new_config = function(new_config, root_dir)
        new_config.cmd_env = new_config.cmd_env or {}
        local env_gowork = vim.env.GOWORK
        if not env_gowork or env_gowork == "" or env_gowork == "off" then
            return
        end
        local expected = vim.fs.normalize(root_dir .. "/go.work")
        local actual = vim.fs.normalize(env_gowork)
        if actual ~= expected then
            new_config.cmd_env.GOWORK = "off"
        end
    end,
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
