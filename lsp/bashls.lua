return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" },
    root_markers = { ".git", ".gitignore" },
    settings = {
        bashIde = {
            shellcheckArguments = "-s zsh",
        },
    },
}
