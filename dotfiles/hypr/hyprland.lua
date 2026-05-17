---@module 'hl.meta'

local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "vicinae toggle"
local browser = "google-chrome"
local clipboard = "vicinae vicinae://launch/clipboard/history"
local emoji = "vicinae vicinae://launch/core/search-emojis"
local mod = "SUPER"

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "BreezeX-Dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- Monitors monitors.conf)
hl.monitor({ output = "", mode = "2560x1440@75", position = "auto", scale = "auto" })

-- Main config
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 12,
		border_size = 2,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 8,
		rounding_power = 2,
		shadow = { enabled = false },
		blur = { enabled = true, size = 8, passes = 2, vibrancy = 0.1696 },
	},
	animations = { enabled = true },
	dwindle = { preserve_split = true },
	master = { new_status = "master" },
	misc = { force_default_wallpaper = 0, disable_hyprland_logo = true },
	input = {
		kb_layout = "us,us",
		kb_variant = ",intl",
		kb_options = "grp:win_space_toggle",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = { natural_scroll = false },
	},
})

-- Bezier + animations
hl.curve("myBezier", { type = "bezier", points = { { 0.08, 0.85 }, { 0.15, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "myBezier", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "default", style = "fade" })

-- Window/layer rules
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

-- Binds (was bindings.conf). Key format: "MOD + KEY"
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.float())
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen_state({ internal = 1, client = -1 }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 2, client = -1 }))
hl.bind(mod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot -d ~/Pictures/Screenshots"))
hl.bind("CTRL + ALT + E", hl.dsp.exec_cmd(emoji))

-- Move window / move focus (arrows)
for _, d in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mod .. " + SHIFT + " .. d, hl.dsp.window.move({ direction = d }))
	hl.bind(mod .. " + " .. d, hl.dsp.focus({ direction = d }))
end

-- Workspaces 1..10
for i = 1, 10 do
	local key = tostring(i % 10)
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse drag (bindm)
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag("move"), { drag = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.drag("resize"), { drag = true })

-- Multimedia: bindel = locked + repeating, bindl = locked
local locked = { locked = true }
local locked_rep = { locked = true, repeating = true }

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), locked_rep)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), locked_rep)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked_rep)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked_rep)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), locked_rep)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), locked_rep)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)

-- Autostart (was autostart.conf) + DMS hyprlang bridge
hl.on("hyprland.start", function()
	-- hl.exec_cmd("awww-daemon")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

	-- No Lua API to source hyprlang at parse time; use hyprctl keyword post-start.
	local home = os.getenv("HOME")
	for _, f in ipairs({ "outputs", "colors", "layout", "windowrules", "binds" }) do
		hl.exec_cmd("hyprctl keyword source = " .. home .. "/.config/hypr/dms/" .. f .. ".conf")
	end
end)
