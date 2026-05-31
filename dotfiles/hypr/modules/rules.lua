---@module 'hl.meta'

hl.layer_rule({
	name = "vicinae-blur",
	match = { class = "vicinae" },
	blur = true,
	ignore_alpha = 0,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	name = "no-blur-osd",
	match = { namespace = "dms:osd" },
	blur = false,
})
