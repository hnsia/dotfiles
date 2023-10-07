# dotfiles
My dotfiles configuration.

## Setup instructions (WSL/Linux)
1. Install Linux distro of choice. (and open it in Windows Terminal, if using WSL) 

1. Create a new SSH key following the instructions in [generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

    ```bash
    ssh-keygen -t ed25519 -C "my-email@example.com"
    ```

    ```bash
    eval "$(ssh-agent -s)"
    ```

    ```bash
    ssh-add ~/.ssh/id_ed25519
    ```


1. Clone this repository to a .dotfiles directory in your home and change into that directory.
    ```bash
    git clone https://github.com/hnsia/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

1. Update `./dotfiles/git/.gitconfig` with options specific for your use case.

1. Make all scripts executable and configure git to ignore changes to file permissions.
    ```bash
    git config core.filemode false
    chmod +x **/*.sh
    ```

1. Run install scripts in utility/wsl-linux directory in order of number prefix on shell scripts.
    ```bash
    . ./utility/wsl-linux/1_install-tools.sh
    . ./utility/wsl-linux/2_customize-zsh.sh
    . ./utility/wsl-linux/3_stow-configs.sh
    . ./utility/wsl-linux/4_install-custom-tools.sh
    ```

1. Run any manual installations

### Manual installations (WSL/Linux)
1. Visual Studio Code (from official website)
2. VS Code Extensions

### WSL
1. Fonts from nerdfonts.com
1. Scoop - Package manager + sudo command in windows cmd

## Setup instructions (Mac)
1. Run `git` to install the MacOS/Xcode Dev Tool Suite which also includes git or directly run the install command below.
    ```bash
    xcode-select --install
    ```

1. Create a new SSH key following the instructions in [generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). (This step is slightly different for Mac)

1. Clone this repository to a .dotfiles directory in your home and change into that directory.
    ```bash
    git clone https://github.com/hnsia/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

1. Update `./dotfiles/git/.gitconfig` with options specific for your use case.

1. Make all scripts executable and configure git to ignore changes to file permissions.
    ```bash
    git config core.filemode false
    chmod +x **/*.sh
    ```

1. Run install scripts in utility/mac directory in order of number prefix on shell scripts.
    ```bash
    . ./utility/mac/1_fresh-install.sh
    . ./utility/mac/2_customize-zsh.sh
    . ./utility/mac/3_stow-configs.sh
    ```

1. Run any manual installations
    

### Manual installations (Mac)
1. NVM
    ```bash
    nvm install --lts
    ```

1. Yarn
    ```bash
    npm install --global yarn
    ```

1. Python
    ```bash
    pyenv install 2
    ```

## TODO
1. Custom tools, e.g. redis, kubectl