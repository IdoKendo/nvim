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

local function url_encode(value)
    return tostring(value):gsub("([^%w%-%._~])", function(char)
        return string.format("%%%02X", string.byte(char))
    end)
end

local function databricks_url()
    local warehouse_id = vim.env.DATABRICKS_SQL_WAREHOUSE_ID
    if not warehouse_id or warehouse_id == "" then
        return nil
    end

    local query = {}
    local profile = vim.env.DATABRICKS_CONFIG_PROFILE or vim.env.DATABRICKS_PROFILE
    if profile and profile ~= "" then
        table.insert(query, "profile=" .. url_encode(profile))
    end
    if vim.env.DATABRICKS_CATALOG and vim.env.DATABRICKS_CATALOG ~= "" then
        table.insert(query, "catalog=" .. url_encode(vim.env.DATABRICKS_CATALOG))
    end
    if vim.env.DATABRICKS_SCHEMA and vim.env.DATABRICKS_SCHEMA ~= "" then
        table.insert(query, "schema=" .. url_encode(vim.env.DATABRICKS_SCHEMA))
    end

    local url = "databricks:" .. url_encode(warehouse_id)
    if #query > 0 then
        url = url .. "?" .. table.concat(query, "&")
    end
    return url
end

local databricks_connection = databricks_url()
if databricks_connection then
    local dbs = type(vim.g.dbs) == "table" and vim.g.dbs or {}
    if dbs.Databricks == nil then
        dbs.Databricks = databricks_connection
    end
    vim.g.dbs = dbs
end

local table_helpers = type(vim.g.db_ui_table_helpers) == "table" and vim.g.db_ui_table_helpers or {}
table_helpers.databricks = table_helpers.databricks or table_helpers.Databricks or {
    List = "SELECT * FROM {table} LIMIT 200",
    Columns = "DESCRIBE TABLE {table}",
}
vim.g.db_ui_table_helpers = table_helpers

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
