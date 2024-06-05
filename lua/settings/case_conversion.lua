local function CaseConvertFunc(conversion, start_line, end_line)
    local modifiers = "ge"
    local selection_mod = "\\%V"
    local search_for, replace_with

    if conversion == "CamelToKebab" then
        search_for = "\\(\\<\\u\\l\\+\\|\\l\\+\\)\\(\\u\\)"
        replace_with = "\\l\\1-\\l\\2"
    elseif conversion == "CamelToSnake" then
        search_for = "\\(\\<\\u\\l\\+\\|\\l\\+\\)\\(\\u\\)"
        replace_with = "\\l\\1_\\l\\2"
    elseif conversion == "KebabToCamel" then
        search_for = "\\(\\k\\+\\)-\\(\\k\\)"
        replace_with = "\\1\\u\\2"
    elseif conversion == "KebabToSnake" then
        search_for = "\\(\\k\\+\\)-\\(\\k\\)"
        replace_with = "\\1_\\2"
    elseif conversion == "SnakeToCamel" then
        search_for = "\\(\\k\\+\\)_\\(\\k\\)"
        replace_with = "\\1\\u\\2"
    elseif conversion == "SnakeToKebab" then
        search_for = "\\(\\k\\+\\)_\\(\\k\\)"
        replace_with = "\\1-\\2"
    end

    vim.cmd(
        string.format("%s,%ss#%s%s#%s#%s#", start_line, end_line, selection_mod, search_for, replace_with, modifiers)
    )
end

vim.api.nvim_create_user_command("CamelToKebab", function(args)
    CaseConvertFunc("CamelToKebab", args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_create_user_command("CamelToSnake", function(args)
    CaseConvertFunc("CamelToSnake", args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_create_user_command("KebabToCamel", function(args)
    CaseConvertFunc("KebabToCamel", args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_create_user_command("KebabToSnake", function(args)
    CaseConvertFunc("KebabToSnake", args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_create_user_command("SnakeToCamel", function(args)
    CaseConvertFunc("SnakeToCamel", args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_create_user_command("SnakeToKebab", function(args)
    CaseConvertFunc("SnakeToKebab", args.line1, args.line2)
end, { range = true, bang = true })

vim.keymap.set("v", "<leader>rcs", ":CamelToSnake<CR>", { desc = "[R]ewrite [C]amel to [S]nake" })
vim.keymap.set("v", "<leader>rck", ":CamelToKebab<CR>", { desc = "[R]ewrite [C]amel to [K]ebab" })
vim.keymap.set("v", "<leader>rsc", ":SnakeToCamel<CR>", { desc = "[R]ewrite [S]nake to [C]amel" })
vim.keymap.set("v", "<leader>rsk", ":SnakeToKebab<CR>", { desc = "[R]ewrite [S]nake to [K]ebab" })
vim.keymap.set("v", "<leader>rkc", ":KebabToCamel<CR>", { desc = "[R]ewrite [K]ebab to [C]amel" })
vim.keymap.set("v", "<leader>rks", ":KebabToSnake<CR>", { desc = "[R]ewrite [K]ebab to [S]nake" })
