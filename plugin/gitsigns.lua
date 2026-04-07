vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "[G]it [T]oggle blame" })
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it [P]review hunk" })
vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [S]tage hunk" })
vim.keymap.set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset hunk" })
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Next [H]unk" })
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Previous [H]unk" })
vim.keymap.set("n", "<leader>gS", function()
    local sha = vim.fn.input("Commit SHA: ")
    if sha and sha ~= "" then
        local command = ":Gitsigns show " .. sha
        vim.cmd(command)
    end
end, { desc = "[G]it [S]how commit" })

require("gitsigns").setup()
