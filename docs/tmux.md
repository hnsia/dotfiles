# Terminal session persistence (tmux)

The goal is to get your terminal workspace back after an **unexpected OS restart**
(forced reboots from OS updates or security policies), not just after closing the
terminal app. This is handled by `tmux` plus two plugins.

| Tool | Purpose |
|---|---|
| [tmux](https://github.com/tmux/tmux) | Sessions, windows, panes, layouts |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Saves/restores sessions, layouts, working directories, and scrollback |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Saves automatically every 5 min and restores on the next tmux start |

Config lives in `common/tmux/.tmux.conf` (stowed to `~/.tmux.conf`). Plugins are
managed by [TPM](https://github.com/tmux-plugins/tpm). Runtime state — installed
plugins in `~/.tmux/plugins/` and saved snapshots in
`~/.local/share/tmux/resurrect/` — lives in `$HOME`, outside the dotfiles repo,
so nothing machine-specific is committed.

## First-time plugin install

The platform setup installs TPM, the plugin manager, alongside tmux itself
(macOS: `1_fresh-install.sh`; WSL: `4_install-custom-tools.sh`). After running
setup, install the plugins once:

```bash
# start tmux, then press: prefix + I  (Ctrl-b, then Shift-i)
tmux
```

`prefix + I` installs `tmux-resurrect` and `tmux-continuum`. From then on,
continuum saves the environment every 5 minutes and restores it automatically the
next time tmux starts.

If TPM is missing (e.g. you didn't run the setup script), clone it first:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Daily use

```bash
tmux                 # start a new session
tmux attach          # reattach to a running session
```

tmux keeps running in the background across terminal-app closures. The default
prefix is `Ctrl-b`.

- `prefix + I` — reinstall/update plugins
- `prefix + R` — reload `~/.tmux.conf`
- `prefix + Ctrl-s` — save the environment now (normally automatic)
- `prefix + Ctrl-r` — restore the saved environment manually

## Recovery after an unexpected restart

1. Open the terminal and run `tmux`. The server starts and `tmux-continuum`
   **automatically restores** your last saved sessions, windows, panes, layouts,
   working directories, and scrollback.
2. Restart any interrupted processes (dev servers, log tails). These do **not**
   survive a reboot — only the layout, working directory, and captured scrollback
   come back. The restored scrollback shows what each pane was last doing.
3. Resume coding agents natively (see below).

## Coding agents (Claude Code / Codex / OpenCode)

A reboot ends the agent process, so any pending question or permission prompt that
only existed in memory is gone. But each tool persists its **conversation
transcript**, so resuming replays the context — including the last question it
asked, which is also still visible in the restored tmux scrollback. From the
restored pane (already in the right working directory):

```bash
claude -c              # continue the most recent Claude Code session in this dir
claude -r              # or pick a session interactively (/resume also works in-app)
codex resume --last    # continue the most recent Codex session
codex resume           # or pick from the session list
opencode               # then pick the previous session to resume
```

Re-answer the pending question in the resumed conversation.

## Design notes

- The prefix stays at the default `Ctrl-b` to avoid keybinding conflicts.
- Running processes are intentionally **not** auto-restarted. Relaunching a coding
  agent would start a fresh session rather than resume one, so resurrect restores
  only the working directory and scrollback; you resume agents natively (above).
- tmux is installed by the platform setup: the Brewfile on macOS, and
  `4_install-custom-tools.sh` on WSL.
