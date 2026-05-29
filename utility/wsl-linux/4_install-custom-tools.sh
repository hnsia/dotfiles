#!/bin/zsh

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
    git clone --depth 1 "$repo" "$target"
  fi
}

# NVM
echo '[*] Installing nvm and node...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Load nvm for this script without relying on a shell restart.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Node
nvm install --lts

# Install fzf
clone_or_update https://github.com/junegunn/fzf.git "$HOME/.fzf" || exit 1
"$HOME/.fzf/install" --key-bindings --completion --no-update-rc

# Install tmux
sudo apt install tmux

# Install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
rm ripgrep_14.1.1-1_amd64.deb

echo '[*] Done. Refresh your shell with: exec zsh -l'
