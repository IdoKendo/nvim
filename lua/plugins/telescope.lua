return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { 
        {"nvim-lua/plenary.nvim"},
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ind [F]iles" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[F]ind [S]tring" })
        vim.keymap.set('n', '<leader>vl', builtin.resume, { desc = "[V]iew [L]ast" })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "[V]iew [H]elp" })
        vim.keymap.set('n', '<leader>dd', builtin.diagnostics, { desc = "[D]etailed [D]iagnostics" })
        vim.keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = "[D]iagnostic [F]loat" })

        function vim.get_visual_selection()
            vim.cmd('noau normal! "vy"')
            local text = vim.fn.getreg('v')
            text = string.gsub(text, "\n", "")
            if #text > 0 then
                return text
            else
                return ''
            end
        end

        vim.keymap.set('v', '<leader>fs', function()
            local text = vim.get_visual_selection()
            builtin.grep_string()
        end, { noremap = true, silent = true, desc = "[F]ind [S]tring" })
    end
}
