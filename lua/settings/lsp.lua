vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

local function get_filenames_without_suffix(dir)
    local files = {}
    local handle = vim.loop.fs_scandir(dir)
    if handle then
        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            local name_without_ext = name:match("(.+)%..+$") or name
            table.insert(files, name_without_ext)
        end
    end
    return files
end

local filenames = get_filenames_without_suffix(vim.fn.stdpath("config") .. "/lsp")
vim.lsp.enable(filenames)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration()" })
vim.diagnostic.config({ virtual_text = true })
