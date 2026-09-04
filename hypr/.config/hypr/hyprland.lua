hl.env("AQ_NO_MODIFIERS", "1")

-- Hyprland 0.56.1 configuration
-- Converted from the previous hyprland.conf

local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "rofi -show drun"

--------------------------------------------------
-- Monitor fallback
--------------------------------------------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "3440x1440@50.00",
	position = "1920x0",
	scale = 1,
})
--------------------------------------------------
-- Environment
--------------------------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--------------------------------------------------
-- General appearance
--------------------------------------------------

hl.config({
	general = {
		layout = "dwindle",
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,

		col = {
			active_border = {
				colors = {
					"rgb(58a6ff)",
					"rgb(ff7b72)",
				},
				angle = 45,
			},

			inactive_border = "rgb(21262d)",
		},

		resize_on_border = true,
	},

	decoration = {
		rounding = 6,
		active_opacity = 1.0,
		inactive_opacity = 0.95,

		blur = {
			enabled = false,
		},

		shadow = {
			enabled = true,
			range = 10,
			color = "rgba(000000cc)",
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	dwindle = {
		force_split = 0,
		preserve_split = true,
	},
})

--------------------------------------------------
-- Startup applications
--------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg -i /home/curt/wallpaper/wallpaper.png -m fill")
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

--------------------------------------------------
-- Volume and brightness
--------------------------------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), {
	locked = true,
	repeating = true,
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), {
	locked = true,
	repeating = true,
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), {
	locked = true,
})

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), {
	locked = true,
	repeating = true,
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), {
	locked = true,
	repeating = true,
})

--------------------------------------------------
-- Screenshots and screen recording
--------------------------------------------------

hl.bind("SHIFT + code:107", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))

hl.bind("code:107", hl.dsp.exec_cmd([[grim "$HOME/Pictures/screenshot-$(date +%s).png"]]))

hl.bind("CTRL + code:107", hl.dsp.exec_cmd("$HOME/.local/bin/grimvideo.sh"))

hl.bind("SUPER + code:118", hl.dsp.exec_cmd([[grim "$HOME/Pictures/screenshot-$(date +%s).png"]]))

hl.bind("SUPER + SHIFT + code:118", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))

hl.bind("SUPER + CTRL + code:118", hl.dsp.exec_cmd("$HOME/.local/bin/grimvideo.sh"))

--------------------------------------------------
-- Main bindings
--------------------------------------------------

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + C", hl.dsp.window.close())

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e yazi"))

hl.bind(
	mainMod .. " + V",
	hl.dsp.window.float({
		action = "toggle",
	})
)

hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({
		action = "toggle",
	})
)

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + H", function()
	hl.dispatch(hl.dsp.layout("preselect l"))
	hl.dispatch(hl.dsp.exec_cmd(terminal))
end)

hl.bind(mainMod .. " + L", function()
	hl.dispatch(hl.dsp.layout("preselect r"))
	hl.dispatch(hl.dsp.exec_cmd(terminal))
end)

hl.bind(mainMod .. " + K", function()
	hl.dispatch(hl.dsp.layout("preselect u"))
	hl.dispatch(hl.dsp.exec_cmd(terminal))
end)

hl.bind(mainMod .. " + J", function()
	hl.dispatch(hl.dsp.layout("preselect d"))
	hl.dispatch(hl.dsp.exec_cmd(terminal))
end)

hl.bind("mouse:275", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("mouse:276", hl.dsp.focus({ workspace = "e+1" }))

--------------------------------------------------
-- Scratchpad
--------------------------------------------------

hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({
		workspace = "special:scratchpad",
	})
)

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))

--------------------------------------------------
-- Workspaces
--------------------------------------------------

for i = 1, 9 do
	hl.bind(
		mainMod .. " + " .. i,
		hl.dsp.focus({
			workspace = i,
		})
	)

	hl.bind(
		mainMod .. " + SHIFT + " .. i,
		hl.dsp.window.move({
			workspace = i,
		})
	)
end

hl.bind(
	mainMod .. " + mouse_down",
	hl.dsp.focus({
		workspace = "e+1",
	})
)

hl.bind(
	mainMod .. " + mouse_up",
	hl.dsp.focus({
		workspace = "e-1",
	})
)

--------------------------------------------------
-- Focus movement
--------------------------------------------------

hl.bind(
	mainMod .. " + left",
	hl.dsp.focus({
		direction = "left",
	})
)

hl.bind(
	mainMod .. " + right",
	hl.dsp.focus({
		direction = "right",
	})
)

hl.bind(
	mainMod .. " + up",
	hl.dsp.focus({
		direction = "up",
	})
)

hl.bind(
	mainMod .. " + down",
	hl.dsp.focus({
		direction = "down",
	})
)

--------------------------------------------------
-- Resize active window
--------------------------------------------------

hl.bind(
	mainMod .. " + CTRL + right",
	hl.dsp.window.resize({
		x = 40,
		y = 0,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + CTRL + left",
	hl.dsp.window.resize({
		x = -40,
		y = 0,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + CTRL + up",
	hl.dsp.window.resize({
		x = 0,
		y = -40,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + CTRL + down",
	hl.dsp.window.resize({
		x = 0,
		y = 40,
		relative = true,
	})
)
--------------------------------------------------
-- Move active floating window
--------------------------------------------------

hl.bind(
	mainMod .. " + SHIFT + left",
	hl.dsp.window.move({
		x = -40,
		y = 0,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + SHIFT + right",
	hl.dsp.window.move({
		x = 40,
		y = 0,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + SHIFT + up",
	hl.dsp.window.move({
		x = 0,
		y = -40,
		relative = true,
	})
)

hl.bind(
	mainMod .. " + SHIFT + down",
	hl.dsp.window.move({
		x = 0,
		y = 40,
		relative = true,
	})
)

--------------------------------------------------
-- Mouse movement and resizing
--------------------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {
	mouse = true,
})

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {
	mouse = true,
})

--------------------------------------------------
-- TUI monitors
--------------------------------------------------

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(terminal .. " --class=sysmonitor -e btm"))

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(terminal .. " --class=sysmonitor -e cava"))

--------------------------------------------------
-- Window rules
--------------------------------------------------

hl.window_rule({
	name = "sysmonitor-window",

	match = {
		class = "^sysmonitor$",
	},

	float = true,
	size = {
		800,
		500,
	},

	move = {
		20,
		20,
	},
})

hl.window_rule({
	name = "pavucontrol-window",

	match = {
		class = "^pavucontrol$",
	},

	float = true,

	move = {
		"monitor_w / 2 - window_w / 2",
		"monitor_h / 2 - window_h / 2",
	},
})
