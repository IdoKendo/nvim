local function try_colorschemes(...)
    for _, cs in ipairs({ ... }) do
        local ok = pcall(vim.cmd.colorscheme, cs)
        if ok then
            return
        end
    end
    vim.notify("No preferred colorschemes found. Using 'unokai'.", vim.log.levels.WARN)
    vim.cmd.colorscheme("unokai")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

try_colorschemes("tokyonight")
