---@module 'hl.meta'

-- Autostart (was autostart.conf). The DMS bridge runs at parse time in
-- dms.lua, not here.
hl.on("hyprland.start", function()
	-- hl.exec_cmd("awww-daemon")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)
