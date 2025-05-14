local builtin = require("telescope.builtin")
local config = require("telescope.config")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", function()
    builtin.git_files({ recurse_submodules = true })
end, { desc = "[F]ind [G]it files" })
vim.keymap.set(
    "n",
    "grr",
    builtin.lsp_references,
    { desc = 'require("telescope.builtin").lsp_references()', noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "gd",
    builtin.lsp_definitions,
    { desc = 'require("telescope.builtin").lsp_definitions()', noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "gi",
    builtin.lsp_implementations,
    { desc = 'require("telescope.builtin").lsp_implementations()', noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>fs", function()
    local opts = {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local parts = vim.split(prompt, "  ")
            local args = { "rg" }
            if parts[1] then
                table.insert(args, "-e")
                table.insert(args, parts[1])
            end

            if parts[2] then
                table.insert(args, "-g")
                table.insert(args, parts[2])
            end

            ---@diagnostic disable-next-line: deprecated
            return vim.tbl_flatten({
                args,
                {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
            })
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    pickers
        .new(opts, {
            debounce = 100,
            prompt_title = "Find String",
            finder = finder,
            previewer = config.values.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end, { desc = "[F]ind [S]tring" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fd", function()
    builtin.diagnostics({ root_dir = vim.fn.getcwd() })
end, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set(
    { "v", "n" },
    "<leader>fw",
    builtin.grep_string,
    { noremap = true, silent = true, desc = "[F]ind [W]ord" }
)
vim.keymap.set("n", "<leader>fn", "<cmd>cnext<CR>", { noremap = true, silent = true, desc = "[F]ind [N]ext" })
vim.keymap.set("n", "<leader>fp", "<cmd>cprev<CR>", { noremap = true, silent = true, desc = "[F]ind [P]revious" })
vim.keymap.set("n", "<leader>tq", function()
    local is_open = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            is_open = true
            break
        end
    end
    if is_open then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "[T]oggle [Q]uickfix" })
