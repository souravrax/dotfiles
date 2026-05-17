# ---------- Starship ----------
eval "$(starship init zsh)"

# ---------- Zoxide ----------
eval "$(zoxide init zsh)"

# ---------- Completion ----------
autoload -Uz compinit
compinit

# ---------- Antidote Helpers ----------
# Add a plugin to ~/.zsh_plugins.txt and reload
# Usage: antidote-add <owner/repo> [annotations...]
antidote-add() {
  local entry="$*"
  if [[ -z "$entry" ]]; then
    echo "Usage: antidote-add <owner/repo> [annotations...]"
    return 1
  fi

  local repo="${entry%% *}"
  if grep -q "^${repo}" ~/.zsh_plugins.txt 2>/dev/null; then
    echo "⊘ $repo is already in ~/.zsh_plugins.txt"
    return 0
  fi

  echo "$entry" >> ~/.zsh_plugins.txt
  echo "✓ Added '$entry' to ~/.zsh_plugins.txt"
  antidote load ~/.zsh_plugins.txt
}

# Remove a plugin from ~/.zsh_plugins.txt and purge
# Usage: antidote-rm <owner/repo>
antidote-rm() {
  local repo="$1"
  if [[ -z "$repo" ]]; then
    echo "Usage: antidote-rm <owner/repo>"
    return 1
  fi

  if ! grep -q "^${repo}" ~/.zsh_plugins.txt 2>/dev/null; then
    echo "✗ $repo not found in ~/.zsh_plugins.txt"
    return 1
  fi

  grep -v "^${repo}" ~/.zsh_plugins.txt > ~/.zsh_plugins.txt.tmp
  mv ~/.zsh_plugins.txt.tmp ~/.zsh_plugins.txt
  echo "✓ Removed $repo from ~/.zsh_plugins.txt"

  antidote purge "$repo" 2>/dev/null || true
  antidote load ~/.zsh_plugins.txt
}
