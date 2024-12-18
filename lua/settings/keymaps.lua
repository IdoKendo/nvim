-- Buffer navigation
vim.keymap.set("n", "}", "}zz", { desc = "Next empty line" })
vim.keymap.set("n", "{", "{zz", { desc = "Previous empty line" })

-- Buffer manipulation
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste and keep clipboard" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Diagnostic
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "[D]iagnostic [F]loat" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[D]iagnostic [Q]uickfix list" })

-- New session script
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/session.sh<CR>")
