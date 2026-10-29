--------------------------------------------------
-- General appearance and behaviour
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

	-- Effects are off: this laptop renders 4K on an Intel HD 630, so every
	-- per-window shader pass costs responsiveness.
	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		-- Fully opaque windows let the renderer skip blending.
		inactive_opacity = 1.0,

		blur = {
			enabled = false,
		},

		shadow = {
			enabled = false,
		},

		glow = {
			enabled = false,
		},

		wobble = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},

	input = {
		-- Don't pass the focusing click through to the window.
		swallow_focus_click = true,
		-- Defaults (600ms / 25Hz) make held keys feel sluggish.
		repeat_delay = 250,
		repeat_rate = 40,
	},

	cursor = {
		-- Warp the cursor to the last focused window when switching monitors.
		warp_on_monitor_change = 1,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		-- 0.57 plays the terminal bell by default.
		bell_sound = "none",
	},

	render = {
		-- 0.57 enables the FP16 work buffer by default; at 4K that doubles
		-- framebuffer bandwidth, which the Intel iGPU can't spare.
		use_fp16 = 0,
		-- Off: its triple buffering adds about a frame of input latency.
		new_render_scheduling = false,
	},

	dwindle = {
		force_split = 0,
		preserve_split = true,
		smart_split = true,
	},
})
