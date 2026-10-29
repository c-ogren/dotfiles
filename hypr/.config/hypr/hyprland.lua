-- Hyprland 0.57.0 configuration
--
-- Entry point; everything lives in modules/ (paths are relative to this file).
--   vars        shared values (mod key, terminal, launcher, wallpaper)
--   env         environment variables
--   monitors    monitor layout
--   appearance  general/decoration/input/misc/layout options
--   autostart   startup applications
--   binds       key and mouse bindings
--   rules       window rules

require("modules.env")
require("modules.monitors")
require("modules.appearance")
require("modules.autostart")
require("modules.binds")
require("modules.rules")
