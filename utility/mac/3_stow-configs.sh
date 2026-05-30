#!/bin/bash

backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

fail() {
  echo "[!] $1" >&2
  return 1
}

run_or_fail() {
  local message="$1"
  shift

  "$@" || fail "$message"
}

backup_existing_config() {
  local target="$1"
  local name

  if [ ! -e "$target" ] && [ ! -L "$target" ]; then
    return
  fi

  name="$(basename "$target")"
  mkdir -p "$backup_dir"
  echo "[*] Backing up existing $target to $backup_dir/$name"
  mv "$target" "$backup_dir/$name"
}

main() {
  # Stow symlinks of configurations to home directory
  echo '[*] Backing up existing configurations...'
  run_or_fail "Failed to back up $HOME/.gitconfig" backup_existing_config "$HOME/.gitconfig" || return 1
  run_or_fail "Failed to back up $HOME/.zshrc" backup_existing_config "$HOME/.zshrc" || return 1
  run_or_fail "Failed to back up $HOME/.zshrc.platform" backup_existing_config "$HOME/.zshrc.platform" || return 1
  run_or_fail "Failed to back up $HOME/.p10k.zsh" backup_existing_config "$HOME/.p10k.zsh" || return 1

  echo '[*] Stowing/Creating symlinks for common and macOS configurations...'

  run_or_fail 'Failed to stow common dotfiles' stow -vSt "$HOME" -d common git zsh pl10k || return 1
  run_or_fail 'Failed to stow macOS dotfiles' stow -vSt "$HOME" -d platform/mac zsh || return 1

  echo '[*] Done. Refresh your shell with: exec zsh -l'
}

main "$@" || exit 1
