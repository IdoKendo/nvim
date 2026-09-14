vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("sniprun_install", { clear = true }),
    callback = function(event)
        if event.data.spec.name ~= "sniprun" or (event.data.kind ~= "install" and event.data.kind ~= "update") then
            return
        end

        vim.notify("Building Sniprun...")
        local result = vim.system({ "sh", "install.sh" }, { cwd = event.data.path, text = true }):wait()
        if result.code ~= 0 or vim.fn.executable(event.data.path .. "/target/release/sniprun") == 0 then
            error("Sniprun installation failed:\n" .. (result.stdout or "") .. (result.stderr or ""))
        end
    end,
})

vim.pack.add({ "https://github.com/michaelb/sniprun" })

require("sniprun").setup({
    display = { "TempFloatingWindow" },
    borders = "rounded",
    -- Python's native runner mistakes Markdown prose for imports from the buffer.
    selected_interpreters = { "Generic" },
    interpreter_options = {
        Generic = {
            Python = {
                supported_filetypes = { "python", "python3", "py" },
                extension = ".py",
                interpreter = "python3",
            },
        },
    },
})

vim.keymap.set({ "n", "x" }, "<leader>rr", "<Plug>SnipRun", { desc = "[R]un snippet" })
