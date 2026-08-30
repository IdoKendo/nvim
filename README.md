# Neovim configuration

## 1) Overview

This repository is my Neovim 0.12+ config.

## 2) Repository structure

```text
.
├── init.lua                    # requires("config")
├── lua/
│   └── config/
│       ├── init.lua            # loads core config modules
│       ├── options.lua
│       ├── keymaps.lua
│       ├── lsp.lua
│       └── ...
├── plugin/                     # plugin declarations + setup
├── ftplugin/                   # filetype-specific plugin loading/config
├── lsp/                        # one file per LSP server definition
├── after/plugin/               # post-plugin overrides
└── nvim-pack-lock.json         # pinned plugin revisions for vim.pack
```

## 3) Prerequisites

### Base requirements

- [Neovim](https://neovim.io/) **>= 0.12.0** (uses `vim.pack` and modern `vim.lsp` APIs).
- [git](https://git-scm.com/) (for cloning + plugin fetches).

### Feature requirements

- **LSP support:** install language servers used in `lsp/*.lua`.
- **Formatting:** install external formatters used in `plugin/conform.lua`.
- **Treesitter parser installation:** [tree-sitter-cli](https://tree-sitter.github.io/tree-sitter/creating-parsers/1-getting-started.html).
- **Telescope search workflow:** [ripgrep (rg)](https://github.com/BurntSushi/ripgrep).
- **Markdown preview:** Node.js/npm for `markdown-preview.nvim` install step.
- **Python debugging:** `debugpy-adapter` executable.
- **Code snapshots:** [silicon](https://github.com/Aloxaf/silicon) binary for `:Silicon`.

## 4) Installation

Clone into your Neovim config directory:

```bash
git clone git@github.com:IdoKendo/nvim.git "$XDG_CONFIG_HOME/nvim"
cd "$XDG_CONFIG_HOME/nvim"
```

Start Neovim once to let `vim.pack` install/update plugins declared in `plugin/*.lua` and `ftplugin/*.lua`.

## 5) First-run verification

Inside Neovim, run:

```vim
:checkhealth
:LspInfo
```

What to verify:

1. `:checkhealth` has no critical failures.
2. `:LspInfo` opens LSP health and shows expected clients when opening relevant filetypes.
