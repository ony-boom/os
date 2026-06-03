---@module 'hl.meta'

require("modules.env")
require("modules.appearance")
require("modules.rules")
require("modules.binds")
require("modules.autostart")
require("dms.colors")
require("dms.cursor")
require("dms.layout")
require("dms.windowrules")

-- host-specific extras, loaded only if stowed for this host (see hosts-dotfiles/)
local config = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
local host = io.open(config .. "/hypr/host.lua", "r")
if host then
	host:close()
	require("host")
end
