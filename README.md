# dotfiles

Personal dotfiles for an Arch Linux + Hyprland (Wayland) desktop, managed with
[GNU Stow](https://www.gnu.org/software/stow/). Everything is themed around a
GitHub Dark look, tuned to be **deutan (red–green colour-blind) friendly**.

## Layout

Each top-level directory is a Stow package whose contents mirror `$HOME`:

```
nvim/.config/nvim/init.lua   ->  ~/.config/nvim/init.lua
zsh/.zshrc                   ->  ~/.zshrc
```

| Area | Packages |
|---|---|
| Desktop | `hypr` (Hyprland Lua config + hyprlock + hypridle), `waybar`, `rofi`, `udiskie` |
| Terminal / shell | `ghostty`, `zsh`, `starship`, `tmux`, `zellij`, `bat` |
| Editor | `nvim` (single `init.lua`, lazy.nvim, pinned via `lazy-lock.json`) |
| Dev tools | `git` (+ git-delta), `mise`, `lazygit`, `lazydocker`, `posting` |
| Session env | `environment` (systemd `environment.d`: `EDITOR`, `PATH`) |
| Scripts | `scripts` (`~/.local/bin`: `grim-video.sh` screen recorder) |
| TUIs | `yazi`, `bottom`, `cava`, `ncspot`, `fastfetch`, `peaclock` |

## Install

The repo is expected at `~/dotfiles` (Stow's default target is the parent
directory, i.e. `$HOME`).

```sh
cd ~/dotfiles
stow zsh nvim hypr waybar   # link individual packages
stow */                     # or everything
stow -D wofi                # unlink a package before deleting it
bat cache --build           # register the custom bat theme (bat + delta use it)
```

Note: Stow "folds" directories, so e.g. `~/.config/nvim` is a single symlink
into this repo. Anything an app writes into its config dir lands in the repo —
runtime state is kept out of git via `.gitignore` (ncspot `userstate.cbor`,
peaclock history, cava's regenerated shaders, gitk's UI state).

## Dependencies

Not exhaustive, but what the configs call out to:

- **Shell:** zsh, zsh-autosuggestions, zsh-syntax-highlighting, starship,
  fzf, zoxide, eza, bat, git-delta, ripgrep, jq, keychain, mise, gh, ufw
- **Desktop:** hyprland, hyprlock, hypridle, waybar, rofi, swaybg, swaync, udiskie, pamixer,
  brightnessctl, grim, slurp, wf-recorder, libnotify, wl-clipboard, pavucontrol, Bibata-Modern-Ice
  cursor, Papirus-Dark icons, JetBrainsMono Nerd Font
- **Apps:** ghostty, neovim (0.11+), tmux, zellij, yazi, imv, zathura, btm,
  cava, ncspot, lazygit, lazydocker, posting, fastfetch, peaclock
- **Neovim tooling:** node/pnpm/prettier/typescript/typescript-language-server
  via `mise`, clangd, clang-format, rustup (rust-analyzer, rustfmt, clippy),
  stylua, eslint (per project), chromium (strudel.nvim)

## Palette

Two closely related GitHub palettes are in use. Both follow the same deutan
rules below.

### Deutan rules

- Never distinguish things by **red vs green alone**. Use blue vs
  yellow/orange, and add a shape or symbol where possible.
- **Blue** = primary / active / added. **Yellow–gold** = warning / changed /
  attention. **Salmon** = error / deleted. **Cyan** = secondary accent.
- Diffs and git signs: add = blue `+`, change = yellow `~`, delete = salmon `_`.
- Ghostty remaps ANSI green (`color2`) to blue, so terminal programs follow
  the same rule automatically.

### GitHub Dark

Used by: ghostty, nvim, rofi, cava, ncspot, zellij, fastfetch, peaclock,
Hyprland borders, eza, bat and git-delta (`bat/.config/bat/themes/github-dark-deutan.tmTheme`),
posting.

| Role | Hex |
|---|---|
| Background | `#0d1117` |
| Surface | `#161b22` |
| Overlay / cursorline | `#21262d` |
| Selection | `#30363d` |
| Muted / bright black | `#484f58` |
| Comment / line numbers | `#6e7681` / `#768390` |
| Foreground | `#c9d1d9` |
| Blue (primary) | `#58a6ff` |
| Blue deep | `#1f6feb` |
| Blue light | `#79c0ff` |
| Cyan | `#39c5cf` |
| Sky (hint) | `#56b4e9` |
| Yellow | `#d29922` |
| Yellow bright | `#e3b341` |
| Salmon (error) | `#ff7b72` |
| Salmon light | `#ffa198` |
| Purple | `#bc8cff` |
| Purple light | `#d2a8ff` |

### GitHub Dark Dimmed

Used by: tmux, starship, lazygit, lazydocker, bottom, waybar, zsh syntax
highlighting.
(tmux and waybar still use `#0d1117` as their background.)

| Role | Hex |
|---|---|
| Background | `#22272E` |
| Surface | `#2D333B` |
| Selection | `#373E47` |
| Border | `#444C56` |
| Muted | `#545D68` |
| Comment | `#768390` |
| Foreground | `#ADBAC7` |
| Foreground bright | `#CDD9E5` |
| Blue (primary) | `#539BF5` |
| Cyan | `#56D4DD` |
| Gold | `#C69026` |
| Gold bright | `#DAAA3F` |
| Green (success, always paired with a symbol) | `#57AB5A` |
| Red (error) | `#E5534B` |
| Purple | `#986EE2` |

## TODO

**Zellij** — not maintained; tmux is the multiplexer in use. Candidate for removal.
- [ ] Plugins referenced in `config.kdl` don't exist (`~/.config/zellij/plugins/`):
      zellij-autolock, zellij_forgot, monocle, room, zellij-sessionizer.
- [ ] Ctrl-key modes steal keys from nvim and zsh (Ctrl+h/n/p/s/t/o/b).
- [ ] Hardcoded `/home/curt` paths and ~570 lines of commented-out defaults.
- [x] Decide between tmux and zellij → tmux.

**Shell**
- [x] `.zshrc` runs `compinit` (dump cached in `~/.cache/zsh/`), with menu-select
      and case-insensitive completion.
- [x] Plugin `source` lines are guarded; arrow/Home/End/Delete keys bound via
      both raw sequences and `$terminfo`.
- [x] `HIST_IGNORE_SPACE` set; `gnew` commits staged changes, or tracked
      changes only (`git add -u`) — never untracked files.
- [x] GUI-launched apps get `EDITOR` and mise's shims on `PATH` via the
      `environment` package (`~/.config/environment.d/envvars.conf`).

**Hyprland / desktop**
- [x] Screen recorder lives in the `scripts` package as `grim-video.sh`.
- [x] hyprlock re-themed to GitHub Dark; shares `~/wallpaper/wallpaper.png` with swaybg.
- [x] `dbus-update-activation-environment --systemd --all` runs before waybar/swaync.
- [x] Removed unused `fileManager`; wallpaper path is a single variable.
- [x] hypridle: dim at 2.5 min, lock at 5, DPMS off at 5.5, suspend at 30.
- [x] Waybar temperature reads coretemp by stable device path; unused
      `workspaces.format-icons` removed.

**Neovim**
- [x] Gitsigns hunk maps moved from `<leader>h*` to `<leader>g*`, so
      `<leader>h` (window left) no longer waits on a timeout.
- [x] flash.nvim's `S` is normal/operator-pending only; nvim-surround owns visual `S`.
- [x] Removed disabled Copilot / CopilotChat specs and the commented keymaps block.

**Misc**
- [x] tmux status: battery found via `BAT*`; CPU sampled over 0.5 s (`top -bn2`)
      instead of the since-boot average.
- [x] `gitk` state untracked and gitignored.
- [x] Unused cava `themes/` removed.
- [x] lazydocker uses Dimmed palette hex colours.
- [x] Starship prompt: blue `❯` on success, red `✗` on error.
- [ ] Unify on one palette (Dark vs Dimmed).

## Potential adds

Ideas not set up yet. Anything added should follow the deutan rules above.

**Untracked configs for tools already in use**
- [ ] swaync: `config.json` + `style.css` in the GitHub Dark palette.
- [ ] zathura (`recolor` mode) and imv.
- [ ] fzf: `FZF_DEFAULT_OPTS` colours in `.zshrc`.
- [ ] zk: `config.toml` and note templates.

**CLI / dev**
- [ ] atuin: SQLite shell history search (replaces Ctrl-R), optional sync.
- [ ] btop: alternative to btm, with a GPU panel.
- [ ] fd: faster `find`; picked up by yazi, fzf and telescope.
- [ ] direnv: per-project env vars (or mise's env support).
- [ ] gh-dash: TUI dashboard for PRs / issues.
- [ ] k9s: Kubernetes TUI.
- [ ] tealdeer (`tldr`): example-based man pages.

**Desktop (Wayland)**
- [ ] hyprpaper or swww: replace swaybg (swww animates transitions).
- [ ] hyprpicker: colour picker.
- [ ] cliphist: clipboard history with a rofi picker.
- [ ] wlogout: themed power menu to match hyprlock.
- [ ] satty or swappy: annotate screenshots after grim/slurp.
- [ ] hyprsunset: blue-light filter.

**TUI apps**
- [ ] aerc or neomutt: email.
- [ ] newsboat: RSS.
- [ ] calcurse: calendar / todos.
- [ ] bluetui, impala (or `nmtui`): Bluetooth / Wi-Fi, launched from waybar clicks.
- [ ] wiremix: TUI audio mixer (could replace pavucontrol).
- [ ] mpv: `mpv.conf` with Wayland + hardware decoding.
- [ ] glow: markdown rendering in the terminal.
- [ ] dust, duf: readable `du` / `df`.

**Repo**
- [ ] Bootstrap script: install a `pkglist.txt` via pacman/paru, then `stow`.
- [ ] Pre-commit check for secrets / runtime state (Stow folding lets apps
      write straight into the repo).
