# dotfiles

GNU Stow packages for an Arch + Hyprland desktop (see `README.md`).

## Hyprland

- Hyprland 0.57 with the Lua config: `hypr/.config/hypr/hyprland.lua` plus
  `modules/`. `hyprctl keyword` may not work with it, so edit the Lua files,
  run `hyprctl reload`, then check `hyprctl configerrors`.
- Use the documented Lua field names (e.g. `border_color` in window rules,
  `active_border` in appearance). Check how the existing module files name
  things before adding keys.
- After visual changes (waybar, colors, fonts, lock screen), take a screenshot
  with `grim` and look at it, or say plainly that it wasn't visually checked.
