vim.keymap.set("n", "}", "}zz", { desc = "Next empty line" })
vim.keymap.set("n", "{", "{zz", { desc = "Previous empty line" })
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = "[F]ile [V]iewer" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste and keep clipboard" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/session.sh<CR>")

vim.keymap.set("n", "<leader>en", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "if [E]rr != [N]il" })
vim.keymap.set(
    "n",
    "<leader>pm",
    'Go<CR><Esc>odef main() -> None:<CR>...<CR><CR><Esc>oif __name__ == "__main__":<CR>main()<Esc>',
    { desc = "[P]ython [M]ain" }
)
