--------------------------------------------------
-- Startup applications
--------------------------------------------------

local vars = require("modules.vars")

hl.on("hyprland.start", function()
	-- Export the session env (WAYLAND_DISPLAY etc.) to systemd/dbus first, so
	-- anything they activate (portals, swaync, ...) can reach the compositor.
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd --all && { waybar & swaync & hypridle & udiskie & }"
	)
	hl.exec_cmd('swaybg -i "' .. vars.wallpaper .. '" -m fill')
end)
