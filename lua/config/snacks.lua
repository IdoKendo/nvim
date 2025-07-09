local snacks = require("snacks")

local function system(cmd, err)
    local proc = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        snacks.notify.error({ err, proc }, { title = "Git Browse" })
        error("__ignore__")
    end
    return vim.split(vim.trim(proc), "\n")
end

local function yank_url()
    local uv = vim.uv or vim.loop
    local file = vim.api.nvim_buf_get_name(0) ---@type string?
    file = file and (uv.fs_stat(file) or {}).type == "file" and svim.fs.normalize(file) or nil
    local cwd = file and vim.fn.fnamemodify(file, ":h") or vim.fn.getcwd()

    local branch = system({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" }, "Failed to get current branch")[1]
    local remote = system({ "git", "-C", cwd, "config", "--get", "remote.origin.url" }, "Failed to get git remote")[1]

    -- Normalize remote URL to HTTPS
    remote = remote:gsub("^git@([^:]+):", "https://%1/"):gsub("%.git$", ""):gsub("^ssh://git@([^/]+)", "https://%1")

    local rel_file = file
        and system({ "git", "-C", cwd, "ls-files", "--full-name", file }, "Failed to get git file path")[1]

    local line_start, line_end
    if vim.fn.mode():find("[vV]") then
        vim.fn.feedkeys(":", "nx")
        line_start = vim.api.nvim_buf_get_mark(0, "<")[1]
        line_end = vim.api.nvim_buf_get_mark(0, ">")[1]
        vim.fn.feedkeys("gv", "nx")
        if line_start > line_end then
            line_start, line_end = line_end, line_start
        end
    else
        line_start = vim.fn.line(".")
        line_end = line_start
    end

    local url = ("%s/blob/%s/%s#L%s%s"):format(
        remote,
        branch,
        rel_file,
        line_start,
        line_start ~= line_end and ("-L" .. line_end) or ""
    )

    vim.fn.setreg("+", url)
    snacks.notify.info({ url }, { title = "Copied Git URL" })
end

vim.keymap.set({ "n", "v" }, "<leader>gY", snacks.gitbrowse.open, { desc = "[G]it [Y]ank" })
vim.keymap.set({ "n", "v" }, "<leader>gy", yank_url, { desc = "[G]it [Y]ank" })
