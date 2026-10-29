local vars = require("modules.vars")
local mainMod = vars.mainMod
local terminal = vars.terminal
local menu = vars.menu

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

local screenshot_monitor =
	[[grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" "$HOME/Pictures/screenshot-$(date +%s).png"]]
local screenshot_region = [[grim -g "$(slurp)" - | wl-copy]]
local screen_record = "$HOME/.local/bin/grim-video.sh"

-- Print (code:107) and SUPER + Insert do the same thing.
for _, key in ipairs({ "code:107", "SUPER + Insert" }) do
	hl.bind(key, hl.dsp.exec_cmd(screenshot_monitor))
	hl.bind("SHIFT + " .. key, hl.dsp.exec_cmd(screenshot_region))
	hl.bind("CTRL + " .. key, hl.dsp.exec_cmd(screen_record))
end

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
