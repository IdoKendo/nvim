return {
    "williamboman/mason.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        local ensure_installed = {
            "basedpyright",
            "bashls",
            "clang-format",
            "clangd",
            "gopls",
            "helm_ls",
            "htmx-lsp",
            "lua_ls",
            "prettier",
            "ruff",
            "rust_analyzer",
            "sqlfmt",
            "stylua",
            "terraform-ls",
            "typos_lsp",
            "yq",
        }

        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,
        })

        require("mason-lspconfig").setup()
    end,
}
