return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        { "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", desc = "[G]it [T]oggle blame" },
        { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "[G]it [P]review hunk" },
        { "<leader>gs", ":Gitsigns stage_hunk<CR>", desc = "[G]it [S]tage hunk", mode = { "n", "v" } },
        { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "[G]it [R]eset hunk", mode = { "n", "v" } },
        { "]h", ":Gitsigns next_hunk<CR>", desc = "Next [H]unk", mode = "n" },
        { "[h", ":Gitsigns prev_hunk<CR>", desc = "Previous [H]unk", mode = "n" },
        {
            "<leader>gS",
            function()
                local sha = vim.fn.input("Commit SHA: ")
                if sha and sha ~= "" then
                    local command = ":Gitsigns show " .. sha
                    vim.cmd(command)
                end
            end,
            desc = "[G]it [S]how commit",
            mode = "n",
        },
    },
    config = function()
        require("gitsigns").setup()
    end,
}
