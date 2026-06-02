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
