#!/bin/sh

echo "[*] Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
echo "[*] Checking and installing Oh My Zsh..."
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
echo "[*] Checking and installing Homebrew..."
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
zsh
