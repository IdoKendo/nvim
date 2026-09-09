local vault_path = vim.fs.normalize(vim.fn.expand("~/idokendo"))

local function is_vault_markdown_buffer(bufnr)
    if vim.bo[bufnr].filetype ~= "markdown" then
        return false
    end

    local file_path = vim.api.nvim_buf_get_name(bufnr)
    if file_path == "" then
        return false
    end

    local normalized_path = vim.fs.normalize(file_path)
    return normalized_path == vault_path or normalized_path:find("^" .. vim.pesc(vault_path) .. "/") ~= nil
end

local function ensure_obsidian_setup()
    if vim.g.markdown_obsidian_initialized then
        return true
    end

    local ok, obsidian = pcall(require, "obsidian")
    if not ok then
        return false
    end

    obsidian.setup({
        workspaces = {
            {
                name = "personal",
                path = "~/idokendo",
            },
        },
        mappings = {},
        ui = { enable = false },
    })

    vim.g.markdown_obsidian_initialized = true
    return true
end

if not vim.g.markdown_ftplugin_initialized then
    vim.g.markdown_ftplugin_initialized = true

    local group = vim.api.nvim_create_augroup("markdown_ftplugin", { clear = false })
    vim.api.nvim_create_autocmd("PackChanged", {
        group = group,
        callback = function(event)
            if
                event.data.spec.name ~= "markdown-preview.nvim"
                or (event.data.kind ~= "install" and event.data.kind ~= "update")
            then
                return
            end

            vim.cmd.packadd("markdown-preview.nvim")
            vim.fn["mkdp#util#install"]()
        end,
    })

    vim.pack.add({
        "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        "https://github.com/epwalsh/obsidian.nvim",
        "https://github.com/iamcco/markdown-preview.nvim",
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/nvim-treesitter/nvim-treesitter",
    })

    local ok_render, render_markdown = pcall(require, "render-markdown")
    if ok_render then
        render_markdown.setup({
            latex = { enabled = false },
        })
    end

    vim.keymap.set("n", "<leader>on", function()
        if not is_vault_markdown_buffer(0) or not ensure_obsidian_setup() then
            return
        end
        vim.cmd("ObsidianNew")
    end, { desc = "[O]bsidian [N]ew" })

    vim.keymap.set("n", "gf", function()
        if
            is_vault_markdown_buffer(0)
            and ensure_obsidian_setup()
            and require("obsidian").util.cursor_on_markdown_link()
        then
            return "<cmd>ObsidianFollowLink<CR>"
        end
        return "gf"
    end, { noremap = false, expr = true, buffer = 0 })
end
