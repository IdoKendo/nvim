return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        init = function()
            local auto_install_in_progress = {}
            local ts_indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            local group = vim.api.nvim_create_augroup("dotfiles_treesitter_auto", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function()
                    local ft = vim.bo.filetype
                    if ft ~= "" then
                        local ok_lang, lang = pcall(vim.treesitter.language.get_lang, ft)
                        lang = (ok_lang and lang) or ft

                        if lang and lang ~= "" and not auto_install_in_progress[lang] then
                            local parser_config = require("nvim-treesitter.parsers")[lang]
                            if parser_config then
                                local installed = require("nvim-treesitter.config").get_installed()
                                if not vim.tbl_contains(installed, lang) then
                                    auto_install_in_progress[lang] = true
                                    local ok_install = pcall(require("nvim-treesitter").install, lang)
                                    if ok_install then
                                        vim.defer_fn(function()
                                            auto_install_in_progress[lang] = nil
                                        end, 2000)
                                    else
                                        auto_install_in_progress[lang] = nil
                                    end
                                end
                            end
                        end

                        local ok_start = pcall(vim.treesitter.start)
                        if ok_start then
                            vim.bo.indentexpr = ts_indentexpr
                        elseif vim.bo.indentexpr == ts_indentexpr then
                            vim.bo.indentexpr = ""
                        end
                    end
                end,
            })

            local ensure_installed = { "bash", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
            local already_installed = require("nvim-treesitter.config").get_installed()
            local parsers_to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(already_installed, parser)
                end)
                :totable()

            require("nvim-treesitter").install(parsers_to_install)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        opts = {
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")

            local select_opts = { silent = true }
            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end, select_opts)
            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end, select_opts)
            vim.keymap.set({ "x", "o" }, "aa", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end, select_opts)
            vim.keymap.set({ "x", "o" }, "ia", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end, select_opts)
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@call.outer", "textobjects")
            end, select_opts)
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@call.inner", "textobjects")
            end, select_opts)

            local move_opts = { silent = true }
            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                move.goto_next_start("@function.outer", "textobjects")
            end, move_opts)
            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                move.goto_next_end("@function.outer", "textobjects")
            end, move_opts)
            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end, move_opts)
            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end, move_opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context", -- sticky function definition
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        keys = {
            { "<leader>ttc", ":TSContext toggle<CR>", desc = "[T]oggle [T]reesitter [C]ontext" },
        },
        config = function()
            vim.cmd(":TSContext enable")
        end,
    },
}
