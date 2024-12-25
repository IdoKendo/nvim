return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, { buffer = event.buf, remap = false, desc = "[G]oto [D]efinition" })
                vim.keymap.set("n", "gr", function()
                    vim.lsp.buf.references()
                end, { buffer = event.buf, remap = false, desc = "[G]oto [R]eferences" })
                vim.keymap.set("n", "gI", function()
                    vim.lsp.buf.implementation()
                end, { buffer = event.buf, remap = false, desc = "[G]oto [I]mplementation" })
                vim.keymap.set("n", "gD", function()
                    vim.lsp.buf.declaration()
                end, { buffer = event.buf, remap = false, desc = "[G]oto [D]eclaration" })
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, { buffer = event.buf, remap = false, desc = "Hover" })
                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [W]orkspace [S]ymbol" })
                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [D]escription" })
                vim.keymap.set("n", "<leader>vca", function()
                    vim.lsp.buf.code_action()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [C]ode [A]ction" })
                vim.keymap.set("n", "<leader>vrn", function()
                    vim.lsp.buf.rename()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [R]e[N]ame" })
                vim.keymap.set("n", "<leader>vrr", function()
                    require("telescope.builtin").lsp_references()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [R]efe[R]ences" })
                vim.keymap.set("i", "<leader>vsh", function()
                    vim.lsp.buf.signature_help()
                end, { buffer = event.buf, remap = false, desc = "[V]iew [S]ignature [H]elp" })

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    vim.keymap.set("n", "<leader>vih", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                    end, { buffer = event.buf, remap = false, desc = "[V]iew [I]nlay [H]ints" })
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        local util = require("lspconfig/util")

        local servers = {
            bashls = {
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh" },
            },
            gopls = {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        buildFlags = { "-tags=cloud" },
                    },
                },
            },
            helm_ls = {
                cmd = { "helm_ls", "serve" },
                filetypes = { "helm" },
            },
            jdtls = {
                filetypes = { "java" },
            },
            lua_ls = {
                filetypes = { "lua" },
                settings = {
                    lua = {
                        runtime = {
                            version = "luajit",
                        },
                        completion = {
                            callsnippet = "replace",
                        },
                        diagnostics = {
                            globals = { "vim", "require" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            },
            pyright = {},
            rust_analyzer = {},
            typos_lsp = {
                cmd_env = { RUST_LOG = "error" },
                init_options = {
                    config = "~/.config/typos/typos.toml",
                    diagnosticSeverity = "Error",
                },
            },
        }

        require("mason").setup()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "htmx-lsp",
            "prettier",
            "ruff",
            "sqlfmt",
            "stylua",
        })
        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,
        })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        vim.diagnostic.config({ virtual_text = true })
    end,
}
