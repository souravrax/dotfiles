#!/usr/bin/env bash

# ============================================================
# setup.sh — Main entry point
#
# This script installs packages and binaries for a reproducible
# development environment. It does NOT manage config files —
# those are handled by chezmoi.
#
# Run after: chezmoi init <repo> && chezmoi apply
# ============================================================

set -euo pipefail

# Ensure ~/.local/bin is available during this session
export PATH="$HOME/.local/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source libraries
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/packages.sh"
source "${SCRIPT_DIR}/lib/binaries.sh"

set_default_shell() {
  local current_shell
  current_shell="$(basename "$SHELL")"

  if [ "$current_shell" = "zsh" ]; then
    print_skip "zsh is already the default shell"
    return
  fi

  print_step "Setting zsh as default shell"
  chsh -s "$(command -v zsh)"
  print_success "Default shell changed to zsh"
}

main() {
  echo "=========================================="
  echo "  Dev Environment Setup"
  echo "=========================================="

  local os
  os="$(detect_os)"

  local arch
  arch="$(detect_arch)"

  if [ "$os" = "unknown" ] || [ "$arch" = "unknown" ]; then
    print_error "Could not detect OS or architecture."
    print_error "OS: ${os}, Arch: ${arch}"
    exit 1
  fi

  echo ""
  echo "Detected platform: ${os} / ${arch}"
  echo ""

  install_packages "$os"
  install_binaries "$os" "$arch"
  install_zsh_plugins
  set_default_shell

  echo ""
  echo "=========================================="
  echo "  Setup Complete!"
  echo "=========================================="
  echo ""
  echo "Next steps:"
  echo "  1. Log out and log back in (for shell change)"
  echo "  2. Install a Nerd Font for Starship icons"
  echo "  3. Ensure chezmoi has applied your configs:"
  echo "       chezmoi apply"
  echo ""
}

main "$@"
