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
vim.lsp.enable({
    "basedpyright",
    "bashls",
    "clangd",
    "gopls",
    "helm_ls",
    "lua_ls",
    "rust_analyzer",
    "typos_lsp",
})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration()" })
vim.diagnostic.config({ virtual_text = true })
