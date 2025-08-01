#!/bin/zsh

# NVM
echo '[*] Installing nvm and node...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# Source zshrc to load nvm and other configurations
source ~/.zshrc

# Install Node
nvm install --lts

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install tmux
sudo apt install tmux

# Install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.1-1_amd64.deb
sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
rm ripgrep_14.1.1-1_amd64.deb

zsh