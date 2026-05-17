#!/usr/bin/env bash

# ============================================================
# packages.sh — OS-specific package installation
# ============================================================

set -euo pipefail

install_packages() {
  local os="$1"

  case "$os" in
    linux)
      install_linux_packages
      ;;
    darwin)
      install_macos_packages
      ;;
    *)
      print_error "Unsupported OS: $os"
      exit 1
      ;;
  esac
}

install_linux_packages() {
  print_step "Updating apt and installing packages"

  sudo apt-get update -qq

  local packages=(
    zsh
    git
    curl
    unzip
    fzf
    zoxide
    bat
    eza
    tmux
    ripgrep
    fd-find
    build-essential
  )

  sudo apt-get install -y -qq "${packages[@]}"
  print_success "apt packages installed"

  # Debian/Ubuntu ships 'bat' as 'batcat' — symlink it so 'bat' works
  if is_installed batcat && [ ! -e "$HOME/.local/bin/bat" ]; then
    print_step "Creating batcat → bat symlink"
    ensure_dir "$HOME/.local/bin"
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    print_success "bat symlink created"
  fi

  # Debian/Ubuntu ships 'fd' as 'fdfind' — symlink it so 'fd' works
  if is_installed fdfind && [ ! -e "$HOME/.local/bin/fd" ]; then
    print_step "Creating fdfind → fd symlink"
    ensure_dir "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    print_success "fd symlink created"
  fi
}

install_macos_packages() {
  if ! is_installed brew; then
    print_error "Homebrew not found. Please install Homebrew first."
    exit 1
  fi

  print_step "Installing packages via Homebrew"

  local packages=(
    zsh
    git
    curl
    unzip
    fzf
    zoxide
    bat
    eza
    tmux
    ripgrep
    fd
  )

  brew install "${packages[@]}"
  print_success "Homebrew packages installed"
}
