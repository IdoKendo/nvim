return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/idokendo/**.md" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "[O]bsidian [N]ew" },
        { "<leader>ogf", "<cmd>ObsidianFollowLink<CR>", desc = "[O]bsidian [G]oto [F]ile" },
    },
    opts = {
        dir = "~/idokendo",
        mappings = {},
    },
}
