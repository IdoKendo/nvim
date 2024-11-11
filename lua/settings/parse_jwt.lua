local function DecodeJWT(start_line, end_line)
    local lines = vim.fn.getline(start_line, end_line)
    if type(lines) == "string" then
        lines = { lines }
    end
    local text = table.concat(lines, "\n")

    local decoded, error_message =
        vim.fn.systemlist("echo " .. vim.fn.shellescape(text) .. " | cut -d '.' -f 2 | basenc -d --base64 | jq")

    if vim.v.shell_error ~= 0 then
        if error_message and #error_message > 0 then
            print("Error decoding JWT: " .. error_message[1])
        else
            print("Error decoding JWT: Unknown error")
        end
        return
    end

    vim.fn.setline(start_line, decoded)
    if #decoded < (end_line - start_line + 1) then
        vim.fn.deletebufline(vim.fn.bufnr(), start_line + #decoded, end_line)
    end
end

vim.api.nvim_create_user_command("DecodeJWT", function(args)
    DecodeJWT(args.line1, args.line2)
end, { range = true, bang = true })

vim.api.nvim_set_keymap("v", "<leader>j", ":DecodeJWT<CR>", { desc = "Decode [J]WT Token" })
