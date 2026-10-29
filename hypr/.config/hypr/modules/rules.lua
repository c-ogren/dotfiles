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

	-- Solid red border so the monitor overlays stand out from regular windows.
	border_color = "rgb(ff7b72)",
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
