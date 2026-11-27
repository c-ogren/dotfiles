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
--   machine/    per-machine overrides, loaded last so they win:
--               laptop.lua (has a battery) or desktop.lua (eye candy)

require("modules.env")
require("modules.monitors")
require("modules.appearance")
require("modules.autostart")
require("modules.binds")
require("modules.rules")

local function has_battery()
	local handle = io.popen("ls -d /sys/class/power_supply/BAT* 2>/dev/null")
	if not handle then
		return false
	end
	local found = handle:read("*l") ~= nil
	handle:close()
	return found
end

require(has_battery() and "modules.machine.laptop" or "modules.machine.desktop")
