#!/bin/bash

# Stow sym links of configurations to home directory
echo '[*] Removing default configurations...'
rm ~/.gitconfig ~/.zshrc ~/.p10k.zsh

echo '[*] Stowing/Creating simlinks for git, zsh, aliases...'

stow -vSt ~ git zsh pl10k