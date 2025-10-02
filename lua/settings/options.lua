-- Enable relative line number
vim.opt.nu = true
vim.opt.rnu = true

-- Don't show mode since it's in status line
vim.opt.showmode = false

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

-- Case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set terminal GUI colors
vim.opt.termguicolors = true

-- Always keep 8 lines below/above/side cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Enable a sign column on cursor
vim.opt.signcolumn = "yes"

-- ??
vim.opt.isfname:append("@-@")

-- Reduce updatetime to 50ms
vim.opt.updatetime = 50

-- Place a column line
vim.opt.colorcolumn = "80"

-- Sets whitespace display
vim.opt.list = true

-- Configure opening splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync with system clipboard,
-- scheduled to reduce startup-time.
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Display markdown nicely
vim.opt.conceallevel = 1

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
