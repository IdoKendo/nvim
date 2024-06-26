return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        { -- Optional
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" }, -- Optional
        { "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "L3MON4D3/LuaSnip" }, -- Required
    },
    config = function()
        local lsp = require("lsp-zero").preset({})
        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")
        local configs = require("lspconfig.configs")
        local mason_tool_installer = require("mason-tool-installer")
        local mason_lsp_config = require("mason-lspconfig")
        local servers = {
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
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
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
        }
        local tools = {
            "htmx-lsp",
            "prettier",
            "ruff",
            "sqlfmt",
            "stylua",
        }

        mason_lsp_config.setup({
            ensure_installed = vim.tbl_keys(servers or {}),
            automatic_installation = true,
        })
        mason_tool_installer.setup({
            ensure_installed = tools,
            automatic_installation = true,
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
            },
        })

        lsp.on_attach(function(client, bufnr)
            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, { buffer = bufnr, remap = false, desc = "[G]oto [D]efinition" })
            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end, { buffer = bufnr, remap = false, desc = "Hover" })
            vim.keymap.set("n", "<leader>vws", function()
                vim.lsp.buf.workspace_symbol()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [W]orkspace [S]ymbol" })
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [D]escription" })
            vim.keymap.set("n", "<leader>vca", function()
                vim.lsp.buf.code_action()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [C]ode [A]ction" })
            vim.keymap.set("n", "<leader>vrn", function()
                vim.lsp.buf.rename()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [R]e[N]ame" })
            vim.keymap.set("n", "<leader>vrr", function()
                require("telescope.builtin").lsp_references()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [R]efe[R]ences" })
            vim.keymap.set("i", "<leader>vsh", function()
                vim.lsp.buf.signature_help()
            end, { buffer = bufnr, remap = false, desc = "[V]iew [S]ignature [H]elp" })
        end)
        lsp.setup()

        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer", keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-q>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
        })

        vim.diagnostic.config({ virtual_text = true })

        lspconfig.gopls.setup(servers.gopls)
        lspconfig.lua_ls.setup(servers.lua_ls)
        lspconfig.jdtls.setup(servers.jdtls)

        lspconfig.htmx.setup({
            filtypes = { "html" },
        })

        if not configs.helm_ls then
            configs.helm_ls = {
                default_config = {
                    cmd = { "helm_ls", "serve" },
                    filetype = { "helm" },
                    root_dir = function(fname)
                        return util.root_patern("Chart.yaml")(fname)
                    end,
                },
            }
        end

        lspconfig.helm_ls.setup(servers.helm_ls)
    end,
}
