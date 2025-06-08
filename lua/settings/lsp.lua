vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("checkhealth vim.lsp")
end, {})

local function get_filenames_without_suffix(dir)
    local files = {}
    local uv = vim.uv
    local handle = uv.fs_scandir(dir)
    if handle then
        while true do
            local name = uv.fs_scandir_next(handle)
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

vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        virtual_text = not vim.diagnostic.config().virtual_text,
    })
end, { desc = "[T]oggle [D]iagnostic lines" })

-- Recognize filetypes for promql lsp
vim.filetype.add({
    extension = {
        promql = "promql",
        prom = "promql",
    },
})
