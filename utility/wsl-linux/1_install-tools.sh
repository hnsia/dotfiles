#!/bin/bash

# APT update
echo '[*] Updating APT...'
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt update && sudo apt upgrade -y

# Meta-packages
echo '[*] Installing meta-packages...'
sudo apt install build-essential -y

# Git
echo '[*] Installing Git...'
sudo apt install git -y

# Stow
sudo apt install stow -y

# Zsh(shell) and Oh My Zsh(Zsh config managing framework)
echo '[*] Installing Zsh...'
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



