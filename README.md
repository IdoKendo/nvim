# nvim
My nvim config files

## Prerequisites

* [git](https://git-scm.com/) ≥ 2.19.0 (`brew install git`)
* [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) ≥ v0.8.0 (`brew install neovim`)
* [ripgrep](https://github.com/BurntSushi/ripgrep) (`brew install ripgrep`)

## Installation
**1**. Following XDG Base Directory Specification, clone the repo to your `$XDG_CONFIG_HOME` directory: `git@github.com:IdoKendo/nvim.git`

```bash
git clone git@github.com:IdoKendo/nvim.git $XDG_CONFIG_HOME/nvim
cd $XDG_CONFIG_HOME/nvim
```

**2**. Run `nvim` in order to install all plugins the first time.

**3**. Inside Neovim, run `:checkhealth` to ensure everything is working and there are no issues.
