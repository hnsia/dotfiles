# dotfiles
My dotfiles configuration

## Setup instructions
1. Install Linux distro of choice. (and open it in Windows Terminal, if using WSL) 

2. Clone this repository to a .dotfiles directory in your home and change into that directory. (consider using SSH)
```bash
git clone https://github.com/hnsia/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

3. Update `./dotfiles/git/.gitconfig` with options specific for your use case.

4. Make all scripts executable and configure git to ignore changes to file permissions.
```bash
git config core.filemode false
chmod +x **/*.sh
```

5. Run install script in order of number prefix on shell scripts.
```bash
. ./utility/1_install-tools.sh
. ./utility/2_customize-zsh.sh
. ./utility/3_stow-configs.sh
. ./utility/4_install-custom-tools.sh
```

## Manual installations
1. Visual Studio Code (from official website)
2. VS Code Extensions

### WSL
2. Fonts from nerdfonts.com
3. Scoop - Package manager + sudo command in windows cmd

## TODO
1. SSH setup
2. Mac version
3. Custom tools, e.g. redis, kubectl