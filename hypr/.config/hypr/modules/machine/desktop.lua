--------------------------------------------------
-- Desktop only (i9-9900K + RTX 5070): eye candy
--------------------------------------------------
-- hyprland.lua loads this on machines without a battery, after
-- appearance.lua, so it overrides the effects-off defaults there.
-- Apply edits with `hyprctl reload`, then check `hyprctl configerrors`.

hl.config({
	decoration = {
		rounding = 12,
		-- 2 is a circle; higher is squarer ("squircle").
		rounding_power = 3,

		active_opacity = 1.0,
		-- Unfocused windows go slightly see-through so the blur shows.
		inactive_opacity = 0.9,

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			noise = 0.02,
			contrast = 0.9,
			brightness = 0.85,
			vibrancy = 0.2,
			popups = true, -- right-click menus
			special = true, -- behind the special workspace

			-- 0 kawase (classic)  1 frost   2 ripple (on click)  3 drops
			-- 4 water (follows the pointer)  5 fluid jar  6 prism
			-- 7 heat shimmer  8 acrylic  9 aurora  10 haze
			-- 3, 5, 7 and 9 animate all the time, so they cost the most GPU.
			variant = 8,

			acrylic = {
				tint = "rgba(0d111733)", -- background colour, low alpha
			},
			-- Only used with variant 9.
			aurora = {
				color1 = "rgba(58a6ffff)", -- blue
				color2 = "rgba(bc8cffff)", -- purple
			},
		},

		shadow = {
			enabled = true,
			range = 24,
			render_power = 3,
			color = "rgba(010409cc)",
			color_inactive = "rgba(01040966)",
			offset = { 0, 6 },
		},

		-- Soft blue inner glow along the focused window's edges.
		glow = {
			enabled = true,
			range = 10,
			render_power = 3,
			color = "rgba(58a6ff40)",
			color_inactive = "rgba(00000000)",
		},

		-- Jelly-like wobble and motion blur while dragging or resizing.
		wobble = {
			enabled = true,
		},
		motion_blur = {
			enabled = true,
		},
	},

	animations = {
		enabled = true,
	},

	render = {
		-- Hyprland's default; appearance.lua turns it off for the laptop iGPU.
		use_fp16 = 2,
	},
})

--------------------------------------------------
-- Animations
--------------------------------------------------
-- Hyprland 0.57's defaults (/usr/share/hypr/hyprland.lua), except that
-- workspaces slide, and the active border's blue-salmon gradient rotates.

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, spring = "easy", style = "slidefade 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
-- One full turn every 10 s. It redraws the border constantly.
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })

--------------------------------------------------
-- Blur behind the bar, launcher and notifications
--------------------------------------------------
-- Their backgrounds are 90-95% opaque, so the blur shows through faintly.
-- ignore_alpha skips fully transparent pixels (margins, rounded corners).

for _, layer in ipairs({ "waybar", "rofi", "swaync-control-center", "swaync-notification-window" }) do
	hl.layer_rule({
		name = "blur-" .. layer,
		match = { namespace = "^" .. layer .. "$" },
		blur = true,
		ignore_alpha = 0.2,
	})
end
