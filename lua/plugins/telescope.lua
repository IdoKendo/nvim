return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<leader>fs", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[F]ind [S]tring" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
        vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "[V]iew [H]elp" })
        vim.keymap.set("n", "<leader>dd", builtin.diagnostics, { desc = "[D]etailed [D]iagnostics" })
        vim.keymap.set("v", "<leader>fs", function()
            builtin.grep_string()
        end, { noremap = true, silent = true, desc = "[F]ind [S]tring" })
    end,
}
