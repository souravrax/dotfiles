#!/usr/bin/env bash

# ============================================================
# binaries.sh — Architecture-specific binary installation
# ============================================================

set -euo pipefail

# Temp working directory for downloads
SETUP_TMP="/tmp/setup-terminal"
ensure_dir "$SETUP_TMP"

install_binaries() {
  local os="$1"
  local arch="$2"

  install_nvim "$os" "$arch"
  install_starship
  install_lazygit "$os" "$arch"
  install_delta "$os" "$arch"
  install_zellij "$os" "$arch"
}

install_nvim() {
  local os="$1"
  local arch="$2"

  if is_installed nvim; then
    print_skip "nvim"
    return
  fi

  print_step "Installing Neovim"

  local version
  version="$(get_latest_github_release neovim neovim)"
  if [ -z "$version" ]; then
    print_error "Could not determine Neovim version"
    exit 1
  fi

  local platform
  case "$os" in
    linux)
      case "$arch" in
        x86_64)  platform="linux-x86_64" ;;
        aarch64) platform="linux-arm64" ;;
      esac
      ;;
    darwin)
      case "$arch" in
        x86_64)  platform="macos-x86_64" ;;
        aarch64) platform="macos-arm64" ;;
      esac
      ;;
  esac

  local url="https://github.com/neovim/neovim/releases/download/v${version}/nvim-${platform}.tar.gz"
  local tarball="$SETUP_TMP/nvim.tar.gz"

  curl -fsSL "$url" -o "$tarball"

  ensure_dir "$HOME/apps"
  rm -rf "$HOME/apps/nvim-${platform}" "$HOME/apps/nvim"
  tar -xzf "$tarball" -C "$HOME/apps"
  ln -s "$HOME/apps/nvim-${platform}" "$HOME/apps/nvim"

  print_success "nvim v${version} installed → ~/apps/nvim"
}

install_starship() {
  if is_installed starship; then
    print_skip "starship"
    return
  fi

  print_step "Installing Starship"
  ensure_dir "$HOME/.local/bin"
  curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$HOME/.local/bin"
  print_success "starship installed"
}

install_lazygit() {
  local os="$1"
  local arch="$2"

  if is_installed lazygit; then
    print_skip "lazygit"
    return
  fi

  print_step "Installing Lazygit"

  local version
  version="$(get_latest_github_release jesseduffield lazygit)"
  if [ -z "$version" ]; then
    print_error "Could not determine Lazygit version"
    exit 1
  fi

  local platform
  case "$os" in
    linux)
      case "$arch" in
        x86_64)  platform="Linux_x86_64" ;;
        aarch64) platform="Linux_arm64" ;;
      esac
      ;;
    darwin)
      case "$arch" in
        x86_64)  platform="Darwin_x86_64" ;;
        aarch64) platform="Darwin_arm64" ;;
      esac
      ;;
  esac

  local url="https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_${platform}.tar.gz"
  local tarball="$SETUP_TMP/lazygit.tar.gz"

  curl -fsSL "$url" -o "$tarball"
  tar -xzf "$tarball" -C "$SETUP_TMP" lazygit

  ensure_dir "$HOME/.local/bin"
  mv "$SETUP_TMP/lazygit" "$HOME/.local/bin/lazygit"
  chmod +x "$HOME/.local/bin/lazygit"

  print_success "lazygit v${version} installed"
}

install_delta() {
  local os="$1"
  local arch="$2"

  if is_installed delta; then
    print_skip "delta"
    return
  fi

  print_step "Installing Delta"

  local version
  version="$(get_latest_github_release dandavison delta)"
  if [ -z "$version" ]; then
    print_error "Could not determine Delta version"
    exit 1
  fi

  local platform
  case "$os" in
    linux)
      case "$arch" in
        x86_64)  platform="x86_64-unknown-linux-gnu" ;;
        aarch64) platform="aarch64-unknown-linux-gnu" ;;
      esac
      ;;
    darwin)
      case "$arch" in
        x86_64)  platform="x86_64-apple-darwin" ;;
        aarch64) platform="aarch64-apple-darwin" ;;
      esac
      ;;
  esac

  local url="https://github.com/dandavison/delta/releases/download/${version}/delta-${version}-${platform}.tar.gz"
  local tarball="$SETUP_TMP/delta.tar.gz"

  curl -fsSL "$url" -o "$tarball"
  tar -xzf "$tarball" -C "$SETUP_TMP"

  # The tarball extracts to a directory like delta-0.17.0-x86_64-...
  local extracted_dir
  extracted_dir="$(ls -d "$SETUP_TMP"/delta-* 2>/dev/null | head -n1)"
  if [ ! -f "${extracted_dir}/delta" ]; then
    print_error "Could not find delta binary in extracted archive"
    exit 1
  fi

  ensure_dir "$HOME/.local/bin"
  mv "${extracted_dir}/delta" "$HOME/.local/bin/delta"
  chmod +x "$HOME/.local/bin/delta"

  print_success "delta ${version} installed"
}

install_zellij() {
  local os="$1"
  local arch="$2"

  if is_installed zellij; then
    print_skip "zellij"
    return
  fi

  print_step "Installing Zellij"

  local version
  version="$(get_latest_github_release zellij-org zellij)"
  if [ -z "$version" ]; then
    print_error "Could not determine Zellij version"
    exit 1
  fi

  local platform
  case "$os" in
    linux)
      case "$arch" in
        x86_64)  platform="x86_64-unknown-linux-musl" ;;
        aarch64) platform="aarch64-unknown-linux-musl" ;;
      esac
      ;;
    darwin)
      case "$arch" in
        x86_64)  platform="x86_64-apple-darwin" ;;
        aarch64) platform="aarch64-apple-darwin" ;;
      esac
      ;;
  esac

  local url="https://github.com/zellij-org/zellij/releases/download/v${version}/zellij-${platform}.tar.gz"
  local tarball="$SETUP_TMP/zellij.tar.gz"

  curl -fsSL "$url" -o "$tarball"
  tar -xzf "$tarball" -C "$SETUP_TMP" zellij

  ensure_dir "$HOME/.local/bin"
  mv "$SETUP_TMP/zellij" "$HOME/.local/bin/zellij"
  chmod +x "$HOME/.local/bin/zellij"

  print_success "zellij v${version} installed"
}

install_zsh_plugins() {
  print_step "Installing zsh plugins"

  ensure_dir "$HOME/.zsh/plugins"

  if [ ! -d "$HOME/.zsh/plugins/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      "$HOME/.zsh/plugins/zsh-autosuggestions"
    print_success "zsh-autosuggestions installed"
  else
    print_skip "zsh-autosuggestions"
  fi

  if [ ! -d "$HOME/.zsh/plugins/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$HOME/.zsh/plugins/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting installed"
  else
    print_skip "zsh-syntax-highlighting"
  fi
}
