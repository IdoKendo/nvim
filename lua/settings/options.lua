-- Enable relative line number
vim.opt.nu = true
vim.opt.rnu = true

-- Set tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable auto indenting
vim.opt.smartindent = true

-- Disable text wrap
vim.opt.wrap = false

-- Setup for persistent undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Set terminal GUI colors
vim.opt.termguicolors = true

-- Always keep 8 lines below/above cursor
vim.opt.scrolloff = 8

-- Enable a sign column on cursor
vim.opt.signcolumn = "yes"

-- ??
vim.opt.isfname:append("@-@")

-- Reduce updatetime to 200ms
vim.opt.updatetime = 50

-- Place a column line
vim.opt.colorcolumn = "80"

-- ??
vim.opt.list = true

-- Connect to system clipboard
vim.opt.clipboard = "unnamedplus"

-- Display markdown nicely
vim.opt.conceallevel = 1

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
