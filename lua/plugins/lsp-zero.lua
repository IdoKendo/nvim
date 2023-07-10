local ensure_installed = {
    "gopls",
    "pyright",
    "rust_analyzer",
}

function keymaps(client, bufnr)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {buffer = bufnr, remap = false, desc = "[G]oto [D]efinition"})
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {buffer = bufnr, remap = false, desc = "Hover"})
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, {buffer = bufnr, remap = false, desc = "[V]iew [W]orkspace [S]ymbol"})
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {buffer = bufnr, remap = false, desc = "[V]iew [D]escription"})
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {buffer = bufnr, remap = false, desc = "[V]iew [C]ode [A]ction"})
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, {buffer = bufnr, remap = false, desc = "[V]iew [R]e[N]ame"})
    vim.keymap.set("n", "<leader>vrr", function() require("telescope.builtin").lsp_references() end, {buffer = bufnr, remap = false, desc = "[V]iew [R]efe[R]ences"})
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, remap = false, desc = "Signature help"})
end

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {                                      -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},         -- Required
            {"hrsh7th/cmp-nvim-lsp"},     -- Required
            {"L3MON4D3/LuaSnip"},         -- Required
        },
        config = function()
            local lsp = require('lsp-zero').preset({})
            local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")

            lsp.ensure_installed(ensure_installed)

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            lsp.on_attach(keymaps)

            lsp.setup()

            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    {name = "path"},
                    {name = "nvim_lsp"},
                    {name = "nvim_lua"},
                    {name = "buffer", keyword_length = 3},
                    {name = "luasnip", keyword_length = 2},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })

            vim.diagnostic.config({ virtual_text = true })

            lspconfig.gopls.setup {
                cmd = {"gopls"},
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                }
            }
        end,
    },
}