#!/usr/bin/env bash

# ============================================================
# utils.sh — Helper functions for the setup script
# ============================================================

set -euo pipefail

print_step() {
  echo ""
  echo "===> $1"
}

print_success() {
  echo "  ✓ $1"
}

print_skip() {
  echo "  ⊘ $1 (already installed)"
}

print_error() {
  echo "  ✗ $1" >&2
}

detect_os() {
  local os
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  case "$os" in
    linux)  echo "linux" ;;
    darwin) echo "darwin" ;;
    *)      echo "unknown" ;;
  esac
}

detect_arch() {
  local arch
  arch="$(uname -m)"
  case "$arch" in
    x86_64)        echo "x86_64" ;;
    aarch64|arm64) echo "aarch64" ;;
    *)             echo "unknown" ;;
  esac
}

is_installed() {
  command -v "$1" >/dev/null 2>&1
}

ensure_dir() {
  mkdir -p "$1"
}

# Fetches the latest release version (tag name without leading 'v') from GitHub.
# Exits the script on failure.
get_latest_github_release() {
  local owner="$1"
  local repo="$2"
  local response

  response="$(curl -fsSL "https://api.github.com/repos/${owner}/${repo}/releases/latest" 2>&1)" || {
    print_error "Failed to fetch latest release for ${owner}/${repo}"
    print_error "$response"
    return 1
  }

  echo "$response" \
    | grep '"tag_name":' \
    | head -n1 \
    | sed -E 's/.*"([^"]+)".*/\1/' \
    | sed 's/^v//'
}
