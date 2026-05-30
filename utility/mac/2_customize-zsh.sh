#!/bin/bash

custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_or_update() {
  local repo="$1"
  local target="$2"

  if [ -d "$target/.git" ]; then
    echo "[*] Updating $target..."
    git -C "$target" pull --ff-only
  elif [ -e "$target" ]; then
    echo "[!] $target already exists but is not a git checkout. Cannot update safely." >&2
    return 1
  else
    echo "[*] Cloning $repo into $target..."
    git clone "$repo" "$target"
  fi
}

mkdir -p "$custom_dir/plugins" "$custom_dir/themes"

# Zsh plugins
clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$custom_dir/plugins/zsh-autosuggestions" || exit 1
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting" || exit 1

# Install Powerlevel10k zsh theme
clone_or_update https://github.com/romkatv/powerlevel10k.git "$custom_dir/themes/powerlevel10k" || exit 1
