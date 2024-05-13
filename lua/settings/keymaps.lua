-- Buffer navigation
vim.keymap.set("n", "}", "}zz", { desc = "Next empty line" })
vim.keymap.set("n", "{", "{zz", { desc = "Previous empty line" })

-- File navigation
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = "[F]ile [V]iewer" })

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
vim.keymap.set("n", "<C-f>", "<cmd>silent !~/.local/scripts/session.sh<CR>")

-- Rebind Netrw refresh
vim.keymap.del("n", "<C-l>")
vim.keymap.set("n", "<leader>ln", "<Plug>NetrwRefresh", { desc = "Re[L]oad [N]etrw" })

-- Stupid fun keymaps
vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "if [E]rr != [N]il" })
vim.keymap.set(
    "n",
    "<leader>pm",
    'Go<CR><Esc>odef main() -> None:<CR>...<CR><CR><Esc>oif __name__ == "__main__":<CR>main()<Esc>',
    { desc = "[P]ython [M]ain" }
)
