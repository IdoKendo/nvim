vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

vim.keymap.set({ "n", "v", "i" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left (tmux)" })
vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down (tmux)" })
vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up (tmux)" })
vim.keymap.set({ "n", "v", "i" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right (tmux)" })
vim.keymap.set({ "n", "v", "i" }, "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate to previous (tmux)" })
