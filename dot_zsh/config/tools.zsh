# ---------- Starship ----------
eval "$(starship init zsh)"

# ---------- Zoxide ----------
eval "$(zoxide init zsh)"

# ---------- Completion ----------
autoload -Uz compinit
compinit
