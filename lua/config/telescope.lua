local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", function()
    builtin.git_files({ recurse_submodules = true })
end, { desc = "[F]ind [G]it files" })
vim.keymap.set("n", "<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[F]ind [S]tring" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("v", "<leader>fs", builtin.grep_string, { noremap = true, silent = true, desc = "[F]ind [S]tring" })
vim.keymap.set("n", "<leader>fn", "<cmd>cnext<CR>", { noremap = true, silent = true, desc = "[F]ind [N]ext" })
vim.keymap.set("n", "<leader>fp", "<cmd>cprev<CR>", { noremap = true, silent = true, desc = "[F]ind [P]revious" })
vim.keymap.set("n", "<leader>tq", function()
    local is_open = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            is_open = true
            break
        end
    end
    if is_open then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "[T]oggle [Q]uickfix" })
