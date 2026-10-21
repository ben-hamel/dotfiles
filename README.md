# My dotfiles

This directory contains the dotfiles for my system, managed with GNU Stow. Each app has its own top-level folder that mirrors the structure of `$HOME`, making it easy to selectively install configs per machine.

## Requirements

Ensure you have the following installed on your system

### Git

```bash
brew install git
```

### Stow

```bash
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```bash
git clone https://github.com/ben-hamel/dotfiles.git
cd dotfiles
```

To symlink everything:

```bash
stow */
```

Or to install a specific app's config:

```bash
stow <app>  #exaple: stow ghostty
```

## Neovim / LazyVim

The `nvim` package stores the LazyVim configuration, enabled extras (`lazyvim.json`),
plugin version lockfile (`lazy-lock.json`), and personal spelling words (`spell/*.add`).

Install Neovim >= 0.11.2 with LuaJIT, Git, curl, ripgrep, fd, tree-sitter CLI,
and a C compiler. Lazygit provides the Git interface; a Nerd Font is recommended
in your terminal for icons. Language servers and formatters may also need Node.js
or other language-specific runtimes.

On Fedora:

```bash
sudo dnf install neovim lazygit ripgrep fd-find tree-sitter-cli gcc curl git stow
```

Lazygit may require an additional repository on some Fedora installations.

On macOS with Homebrew:

```bash
brew install neovim lazygit ripgrep fd tree-sitter git stow
xcode-select --install  # C compiler, if Command Line Tools are not installed
```

Back up any existing `~/.config/nvim` before installing this package, then run:

```bash
cd ~/dotfiles
stow nvim
nvim
```

Plugins are downloaded automatically on first launch using the lockfile. Run
`:LazyHealth` to check the setup and `:Lazy restore` to restore locked versions.
Use `:LazyExtras` for additional language support. Commit config and lockfile
changes after customization or plugin updates.

The `spell/` directory is symlinked so words added with `zg` are stored in this
repo. Compiled `*.spl` and `*.sug` files are ignored. If spelling additions need
rebuilding on a new machine, run `:mkspell! ~/.config/nvim/spell/en.utf-8.add`.
Do not track downloaded plugins, language tools, state, or caches from
`~/.local/share/nvim`, `~/.local/state/nvim`, or `~/.cache/nvim`.

Official docs: [installation](https://www.lazyvim.org/installation),
[configuration](https://www.lazyvim.org/configuration),
[lockfile](https://lazy.folke.io/usage/lockfile).

## Yazi

The `yazi` package stores the Catppuccin Mocha selection and its locked flavor version. After installing matching `yazi` and `ya` binaries on a new machine, run:

```bash
stow yazi
ya pkg install
```

`ya pkg install` restores the flavor into `~/.config/yazi/flavors/`; that downloaded directory does not need to be tracked.
