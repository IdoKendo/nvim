local comment = require('nvim_comment')
comment.setup()

vim.api.nvim_set_keymap('n', '<leader>cc', ':CommentToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>cc', ":'<,'>CommentToggle<CR>", {noremap = true, silent = true})

