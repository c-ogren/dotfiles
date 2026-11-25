# General

## Shell environment

- Shell is zsh. `mv`, `cp` and `rm` are aliased to their interactive forms
  (`-i` / `-I`) and `ls` to `eza`. In tool calls use `command mv`,
  `command cp`, `command ls` (or `\mv`) so nothing prompts or hangs.
- Check snippets meant for `.zshrc` with `zsh -n` before giving them to me.

## Context

- "Windows" usually means my Windows PC (PowerShell, Ghostty, Neovim on
  Windows), not Hyprland windows. Ask if unsure.

## Verifying system changes

- Scripts that change system settings must read each change back (e.g.
  `cat /sys/...`, `findmnt /boot`) before printing success. Never print ✓
  without checking.
