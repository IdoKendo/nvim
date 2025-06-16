local typo_fixes = {
    namepsace = "namespace",
    functino = "function",
    retrun = "return",
    improt = "import",
    pakcage = "package",
}

for typo, correct in pairs(typo_fixes) do
    vim.cmd(string.format("iabbrev %s %s", typo, correct))
end
