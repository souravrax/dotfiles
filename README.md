# dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

- **Neovim** – [LazyVim](https://www.lazyvim.org/) based configuration (`~/.config/nvim`)

## Prerequisites

- [chezmoi](https://www.chezmoi.io/install/) – dotfiles manager
- [Neovim](https://neovim.io/) – if you want to use the editor config
- [Git](https://git-scm.com/)

## Quick Start (New Machine)

1. **Install chezmoi** (if not already installed):
   ```bash
   # Linux / WSL
   sh -c "$(curl -fsLS get.chezmoi.io)"
   
   # Or use your package manager, e.g.:
   # brew install chezmoi
   # apt install chezmoi
   ```

2. **Initialize chezmoi with this repository**:
   ```bash
   chezmoi init https://github.com/souravrax/dotfiles.git
   # or if using SSH:
   chezmoi init git@github.com:souravrax/dotfiles.git
   ```

3. **Review what will change** (optional but recommended):
   ```bash
   chezmoi diff
   ```

4. **Apply the dotfiles**:
   ```bash
   chezmoi apply -v
   ```

## Daily Usage

| Command | Description |
|---------|-------------|
| `chezmoi status` | Show status of files vs the repo |
| `chezmoi diff` | Show differences between actual files and repo |
| `chezmoi add <file>` | Add a new file to the chezmoi repo |
| `chezmoi edit <file>` | Edit a file in the source directory and apply changes |
| `chezmoi apply` | Apply all changes from the repo to your home directory |
| `chezmoi apply <file>` | Apply a specific file |
| `chezmoi re-add` | Re-add any files that have drifted from the repo state |
| `chezmoi update` | Pull latest changes from the repo and apply them |
| `chezmoi cd` | Open a shell in the chezmoi source directory |
| `chezmoi purge` | Remove chezmoi and all managed dotfiles (use with caution!) |

## Making Changes

1. **Edit a managed file**:
   ```bash
   chezmoi edit ~/.config/nvim/init.lua
   ```

2. **Or edit directly in the source directory**:
   ```bash
   chezmoi cd
   # now edit files in the source tree
   ```

3. **See what changed**:
   ```bash
   chezmoi diff
   ```

4. **Commit and push**:
   ```bash
   chezmoi git add .
   chezmoi git commit -m "Update nvim config"
   chezmoi git push
   ```
   
   Or simply use `chezmoi cd` and run git commands directly.

## Repository Structure

```
.
├── README.md
└── private_dot_config/
    └── nvim/              → ~/.config/nvim
        ├── init.lua
        ├── lazy-lock.json
        ├── lazyvim.json
        ├── lua/
        │   ├── config/
        │   │   ├── autocmds.lua
        │   │   ├── keymaps.lua
        │   │   ├── lazy.lua
        │   │   └── options.lua
        │   └── plugins/
        │       └── example.lua
        └── stylua.toml
```

> **Note:** The `private_` prefix tells chezmoi to create the directory/file with restrictive (`0o700`) permissions, ensuring sensitive configuration stays private.

## Tips

- Use `chezmoi doctor` to verify your setup.
- Use `chezmoi dump --format=json` to inspect the final target state.
- Use `chezmoi ignore` to stop managing a file without deleting it from the repo.

## License

This repository is for personal use. Feel free to reference or adapt parts of it for your own dotfiles.
