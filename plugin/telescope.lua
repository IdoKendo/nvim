vim.pack.add({
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
})

local builtin = require("telescope.builtin")
local config = require("telescope.config")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")

local function git_output(args)
    local output = vim.fn.systemlist(args)
    if vim.v.shell_error ~= 0 then
        return nil
    end

    return output
end

local function git_first_line(args)
    local output = git_output(args)
    if not output or output[1] == "" then
        return nil
    end

    return output[1]
end

local function git_root()
    return git_first_line({ "git", "rev-parse", "--show-toplevel" })
end

local function git_current_branch(root)
    return git_first_line({ "git", "-C", root, "branch", "--show-current" })
end

local function git_ref_exists(root, ref)
    return git_output({ "git", "-C", root, "show-ref", "--verify", "--quiet", ref }) ~= nil
end

local function local_default_ref(root, remote, branch)
    if git_ref_exists(root, "refs/heads/" .. branch) then
        return branch
    end

    return remote .. "/" .. branch
end

local function git_default_branch(root)
    local remotes = git_output({ "git", "-C", root, "remote" })
    if not remotes then
        return nil
    end

    local remote_order = vim.deepcopy(remotes)
    if vim.tbl_contains(remote_order, "origin") then
        remote_order = vim.tbl_filter(function(remote)
            return remote ~= "origin"
        end, remote_order)
        table.insert(remote_order, 1, "origin")
    end

    for _, remote in ipairs(remote_order) do
        local ref =
            git_first_line({ "git", "-C", root, "symbolic-ref", "--short", "refs/remotes/" .. remote .. "/HEAD" })
        if ref then
            return local_default_ref(root, remote, ref:sub(#remote + 2))
        end

        local remote_info = git_output({ "git", "-C", root, "remote", "show", "-n", remote })
        if remote_info then
            for _, line in ipairs(remote_info) do
                local branch = line:match("HEAD branch: (.+)$")
                if branch and branch ~= "(unknown)" then
                    return local_default_ref(root, remote, branch)
                end
            end
        end
    end
end

local function git_diff_default_branch()
    local root = git_root()
    if not root then
        vim.notify("Not in a git repository", vim.log.levels.ERROR)
        return
    end

    local default_branch = git_default_branch(root)
    if not default_branch then
        vim.notify("Could not resolve git default branch", vim.log.levels.ERROR)
        return
    end

    local opts = { cwd = root }
    local current_branch = git_current_branch(root)
    local on_default_branch = current_branch == default_branch
    local range = on_default_branch and "HEAD" or "HEAD.." .. default_branch
    local prompt_title = on_default_branch and "Git Diff Local Changes" or "Git Diff " .. range

    pickers
        .new(opts, {
            prompt_title = prompt_title,
            finder = finders.new_oneshot_job({ "git", "-C", root, "diff", "--name-only", range, "--" }, {
                entry_maker = function(file)
                    return {
                        value = file,
                        display = file,
                        ordinal = file,
                        path = root .. "/" .. file,
                        filename = root .. "/" .. file,
                    }
                end,
            }),
            previewer = previewers.new_buffer_previewer({
                title = "Git File Diff",
                define_preview = function(self, entry)
                    local diff = git_output({ "git", "-C", root, "--no-pager", "diff", range, "--", entry.value })
                    if not diff then
                        diff = { "Could not load diff for " .. entry.value }
                    elseif vim.tbl_isempty(diff) then
                        diff = { "No diff for " .. entry.value }
                    end

                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, diff)
                    vim.bo[self.state.bufnr].filetype = "diff"
                end,
            }),
            sorter = config.values.file_sorter(opts),
        })
        :find()
end

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
            return vim.iter({
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
                :flatten()
                :totable()
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
vim.keymap.set("n", "<leader>fm", git_diff_default_branch, { desc = "[F]ind diff with [M]ain branch" })
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
