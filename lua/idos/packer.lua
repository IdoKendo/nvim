vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    }
    use {
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append "space:⋅"
            vim.opt.listchars:append "eol:↴"
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-context"
    use "theprimeagen/harpoon"
    use "mbbill/undotree"
    use "tpope/vim-fugitive"
    use "rhysd/git-messenger.vim"
    use "terrortylor/nvim-comment"
    use "christoomey/vim-tmux-navigator"
    use "mfussenegger/nvim-dap"
    use "mfussenegger/nvim-dap-python"
    use {
        "rcarriga/nvim-dap-ui",
        rquires = { "mfussenegger/nvim-dap" }
    }
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        }
    }
    use "nvim-neotest/neotest-python"
    use {
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async"
    }
    use "projekt0n/github-nvim-theme"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {"williamboman/mason.nvim"},           -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},         -- Required
            {"hrsh7th/cmp-nvim-lsp"},     -- Required
            {"L3MON4D3/LuaSnip"},         -- Required
        }
    }
end)
