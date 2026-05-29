# Dotfiles Repository Concerns

Read-only review performed for a personal dotfiles repository used to set up new Windows/WSL and macOS devices.

## High Priority

1. **Stow setup deletes existing dotfiles without backup or confirmation** - addressed

   Previously, both stow scripts removed existing home-directory config files before creating symlinks:

   - `utility/wsl-linux/3_stow-configs.sh`
   - `utility/mac/3_stow-configs.sh`

   Original behavior:

   ```sh
   rm ~/.gitconfig ~/.zshrc ~/.p10k.zsh
   ```

   This could permanently delete device-specific config on a new or existing machine. The stow scripts now back up existing managed files into `~/.dotfiles-backup/YYYYMMDD-HHMMSS/` before running `stow`.

2. **Remote install scripts are executed directly from moving sources**

   Several scripts pipe remote content directly into `sh` or `bash`, or download from moving targets such as `HEAD`, `master`, or `latest`.

   Examples:

   - Oh My Zsh installer in `utility/wsl-linux/1_install-tools.sh`
   - Oh My Zsh and Homebrew installers in `utility/mac/1_fresh-install.sh`
   - NVM installer in both platform setup flows
   - Neovim `latest` release download in `utility/wsl-linux/4_install-custom-tools.sh`

   This is common in personal bootstrap scripts, but it reduces reproducibility and increases supply-chain risk. Prefer pinned versions, checksum verification where practical, and comments documenting intentional trust boundaries.

3. **WSL ripgrep download likely fails** - addressed

   `utility/wsl-linux/4_install-custom-tools.sh` downloads from a `14.1.0` release path but uses a `14.1.1` package filename:

   ```sh
   curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.1-1_amd64.deb
   sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
   ```

   The version mismatch likely produces a 404 or a missing file during install. Pin the URL and filename to the same release, or install `ripgrep` through the package manager if the packaged version is acceptable.

## Medium Priority

4. **macOS setup assumes Apple Silicon Homebrew path** - addressed

   `utility/mac/1_fresh-install.sh` hardcodes `/opt/homebrew`:

   ```sh
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

   This is correct for Apple Silicon Macs, but Intel Macs typically use `/usr/local/bin/brew`. Detect the installed `brew` path dynamically instead.

5. **Setup scripts spawn interactive `zsh` shells mid-flow** - addressed

   Several scripts previously ended with or contained standalone `zsh`, including:

   - `utility/mac/1_fresh-install.sh`
   - `utility/mac/3_stow-configs.sh`
   - `utility/wsl-linux/3_stow-configs.sh`
   - `utility/wsl-linux/4_install-custom-tools.sh`

   In `utility/mac/1_fresh-install.sh`, `zsh` appeared before the final `fzf` setup line, so the script paused until the nested shell exited. The numbered scripts now finish with a prompt to refresh using `exec zsh -l` instead of replacing the shell themselves.

6. **Setup is not idempotent** - addressed

   Re-running plugin and tool install scripts can fail because clone targets already exist:

   - `zsh-autosuggestions`
   - `zsh-syntax-highlighting`
   - `powerlevel10k`
   - `~/.fzf`

   The zsh plugin/theme scripts and WSL fzf install now check for existing git checkouts and update them with `git pull --ff-only` instead of failing on existing clone targets.

7. **Shared `.zshrc` contains WSL/Linux-specific assumptions** - partially addressed

   `zsh/.zshrc` includes:

   ```sh
   plugins=(git nvm node ubuntu npm zsh-autosuggestions zsh-syntax-highlighting)
   export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
   ```

   The `/opt/nvim-linux-x86_64/bin` path is now commented out, fzf setup supports both cloned and Homebrew installs, and kubectl alias/completion setup is guarded behind `command -v kubectl`. The `ubuntu` plugin is still in the shared plugin list and may need a platform guard or split config later.

## Lower Priority

8. **Neovim Typecraft template hardcodes WSL clipboard commands**

   `nvim-templates/typecraft/init.lua` configures clipboard integration through `clip.exe` and `powershell.exe`:

   ```lua
   vim.g.clipboard = {
     name = 'wsl-clipboard',
     copy = {
       ['+'] = 'clip.exe',
       ['*'] = 'clip.exe',
     },
     paste = {
       ['+'] = 'powershell.exe -Command "Get-Clipboard"',
       ['*'] = 'powershell.exe -Command "Get-Clipboard"',
     },
     cache_enabled = false,
   }
   ```

   This is useful under WSL, but it will fail on native Linux or macOS unless guarded.

9. **Windows Terminal settings are machine-specific**

   `settings.json` includes fixed profile GUIDs, Visual Studio 2019 profile sources, Canonical Store Ubuntu source IDs, and a default profile set to Windows PowerShell.

   This may not transfer cleanly to a new Windows device. Consider documenting that this file is a reference config rather than a blindly stowed file, or split reusable settings from machine-specific profile entries.

## Other Notes

- A quick secret-pattern scan did not find obvious committed secrets or tokens.
- One staged file was present during review: `nvim-templates/kickstart/init.lua`.
- `shellcheck` was not available in the local environment, so shell scripts were reviewed manually rather than with automated shell linting.
