#!/bin/bash

echo "[*] Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
echo "[*] Checking and installing Oh My Zsh..."
# Refer to Issue#1 on github repo for following commented line
# if test ! $(which omz); then
if ! which omz > /dev/null; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
echo "[*] Checking and installing Homebrew..."
# Refer to Issue#1 on github repo for following commented line
# if test ! $(which brew); then
if ! which brew > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x /opt/homebrew/bin/brew ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  elif [ -x /usr/local/bin/brew ]; then
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
  fi
fi

# Load Homebrew for this script without relying on a shell restart.
if command -v brew > /dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo '[!] Homebrew is not available after installation.' >&2
  exit 1
fi

# Update Homebrew recipes
echo "[*] Updating Homebrew itself..."
brew update

# Install all our dependencies with bundle (See /utility/mac/Brewfile)
echo "[*] Installing dependencies and apps with brew..."
brew tap homebrew/bundle
brew bundle --file ./utility/mac/Brewfile

# NVM
echo '[*] Installing nvm and node...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

echo '[*] Done. Refresh your shell with: exec zsh -l'
