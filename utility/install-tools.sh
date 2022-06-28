#!/bin/bash

# Meta-packages
sudo apt update
sudo apt install build-essential -y

# Git
sudo apt-add-repository ppa:git-core/ppa
sudo apt update
sudo apt install git -y

# Stow sym links of configurations to home directory
echo '[*] Removing default configurations...'
rm ~/.gitconfig ~/.zshrc 

echo '[*] Stowing/Creating simlinks for git, zsh, aliases...'
stow -vSt ~ git zsh