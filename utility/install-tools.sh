#!/bin/bash

# Meta-packages
echo '[*] Installing meta-packages...'
sudo apt update
sudo apt install build-essential -y

# Git
echo '[*] Installing Git...'
sudo apt-add-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y

# Zsh(shell) and Oh My Zsh(Zsh config managing framework)
echo '[*] Installing Zsh...'
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# NVM and Node
echo '[*] Installing nvm and node...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts

# Stow sym links of configurations to home directory
echo '[*] Removing default configurations...'
rm ~/.gitconfig ~/.zshrc 

echo '[*] Stowing/Creating simlinks for git, zsh, aliases...'
stow -vSt ~ git zsh