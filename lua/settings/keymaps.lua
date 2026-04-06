-- Buffer navigation
vim.keymap.set("n", "}", "}zz", { desc = "Next empty line" })
vim.keymap.set("n", "{", "{zz", { desc = "Previous empty line" })

-- Buffer manipulation
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste and keep clipboard" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in visual mode after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Diagnostic
local function jump_diag(count)
    vim.diagnostic.jump({
        count = count,
        on_jump = function(diagnostic, bufnr)
            if not diagnostic then
                return
            end
            vim.diagnostic.open_float({
                bufnr = bufnr,
                pos = { diagnostic.lnum, diagnostic.col },
                focusable = false,
            })
        end,
    })
end
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "[D]iagnostic [F]loat" })
vim.keymap.set("n", "[d", function()
    jump_diag(-1)
end, { desc = "Previous [D]iagnostic" })
vim.keymap.set("n", "]d", function()
    jump_diag(1)
end, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[D]iagnostic [Q]uickfix list" })

-- Treesitter
vim.keymap.set("n", "<leader>ttp", ":InspectTree<CR>", { desc = "[T]oggle [T]reesitter [P]layground" })

-- New session script
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/session.sh<CR>")
