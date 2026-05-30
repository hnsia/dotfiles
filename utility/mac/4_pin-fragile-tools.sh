#!/bin/bash

pin_if_installed() {
  local formula="$1"

  if ! brew list --formula "$formula" >/dev/null 2>&1; then
    echo "[!] $formula is not installed. Skipping."
    return
  fi

  echo "[*] Pinning $formula..."
  brew pin "$formula"
}

echo '[*] Pinning fragile Homebrew formulae...'
pin_if_installed kubectl
pin_if_installed redis

echo '[*] Pinned formulae:'
brew list --pinned
