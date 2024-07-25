return {
    "jellydn/hurl.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
        --- Define env file default
        env_file = { ".env" },
        -- Show debugging info
        debug = false,
        -- Show notification on run
        show_notification = false,
        -- Show response in popup or split
        mode = "split",
        -- Default formatter
        formatters = {
            json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
            html = {
                "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                "--parser",
                "html",
            },
            xml = {
                "tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
                "-xml",
                "-i",
                "-q",
            },
        },
    },
    keys = {
        { "<leader>hA", "<cmd>HurlRunner<CR>", desc = "[H]url run [A]ll requests" },
        { "<leader>ha", "<cmd>HurlRunnerAt<CR>", desc = "[H]url run [A]pi request" },
        { "<leader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "[H]url run api request to [E]ntry" },
        { "<leader>ht", "<cmd>HurlToggleMode<CR>", desc = "[H]url [T]oggle" },
        { "<leader>hv", "<cmd>HurlVerbose<CR>", desc = "Run [H]url api in [V]erbose mode" },
        { "<leader>hr", ":HurlRunner<CR>", desc = "[H]url [R]unner", mode = "v" },
    },
}
