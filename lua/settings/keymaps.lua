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
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "[D]iagnostic [F]loat" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[D]iagnostic [Q]uickfix list" })

-- LSP additions
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration()" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "vim.lsp.buf.implementation()" })

-- New session script
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/session.sh<CR>")
