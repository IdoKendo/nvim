vim.pack.add({
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
    "https://github.com/nvim-lua/plenary.nvim",
})

local function db_completion()
    local ok, cmp = pcall(require, "cmp")
    if not ok then
        return
    end
    cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

vim.keymap.set("n", "<leader>db", vim.cmd.DBUIToggle, { desc = "Toggle [D]ata[B]ase" })
vim.keymap.set("v", "<leader>rq", "<Plug>(DBUI_ExecuteQuery)", { desc = "[R]un [Q]uery" })

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql" },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql" },
    command = "setlocal commentstring=--\\ %s",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        vim.schedule(db_completion)
    end,
})
