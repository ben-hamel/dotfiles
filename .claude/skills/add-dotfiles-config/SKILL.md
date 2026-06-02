---
name: add-dotfiles-config
description: Add a new app's config file to the dotfiles repo and symlink it with GNU Stow.
---

<oneliner>
When the user wants to add a new app config to their dotfiles, follow this procedure: find the config, create the Stow package, copy the file, and stow it with --adopt.
</oneliner>

## Procedure

1. Find where the app stores its config — check `~/.config/<app>/` first
2. List all files found and ask the user which ones to include (flag likely runtime files like `*.log`, `*.sock`, `session.json`, `*.pid` but let the user decide)
3. Create the Stow package structure: `mkdir -p <package>/.config/<app>/`
4. Copy the chosen file(s) into the package
5. Run `stow --adopt <package>` from the repo root
6. Verify: `ls -la ~/.config/<app>/` — each file should be a symlink into `dotfiles/`

## Gotchas

- Always run `stow` from the repo root, not from inside the package directory
- `--adopt` moves the live file into the package and creates the symlink — safe here since we copy first
