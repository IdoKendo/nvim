return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>ee", function() require("trouble").toggle() end, desc = "Troubl[E] Toggl[E]" },
        { "<leader>ew", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Troubl[E] [W]orkspace Diagnostics" },
        { "<leader>ed", function() require("trouble").toggle("document_diagnostics") end, desc = "Troubl[E] [D]ocument Diagnostics" },
        { "<leader>eq", function() require("trouble").toggle("quickfix") end, desc = "Troubl[E] [Q]uickfix" },
        { "<leader>el", function() require("trouble").toggle("loclist") end, desc = "Troubl[E] [L]oclist" },
        { "<leader>er", function() require("trouble").toggle("lsp_references") end, desc = "Troubl[E] LSP [R]eferences" },
    },
}
