---@module 'hl.meta'

-- Autostart (was autostart.conf). The DMS bridge runs at parse time in
-- dms.lua, not here.
hl.on("hyprland.start", function()
	-- hl.exec_cmd("awww-daemon")
	-- gnome-keyring's secrets component is already started by PAM
	-- (pam_gnome_keyring at SDDM login), so no manual --start is needed here.
end)
