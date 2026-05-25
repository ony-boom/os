---@module 'hl.meta'

-- DMS hyprlang bridge.
-- DMS auto-generates traditional hyprlang .conf files (dms/colors.conf,
-- dms/layout.conf), but since Hyprland 0.55 the config is parsed by the Lua
-- (non-legacy) parser, where `hyprctl keyword source = ...` fails with
-- "keyword can't work with non-legacy parsers. Use eval." So instead of
-- sourcing them, we parse the .conf files here and apply via hl.config().
-- This runs at config parse time, so `hyprctl reload` re-applies DMS changes;
-- required after appearance.lua so DMS values win.
local function apply_dms()
	local dir = os.getenv("HOME") .. "/.config/hypr/dms/"
	local vars, root = {}, {}

	-- "4" -> 4, "1.5" -> 1.5, everything else (colors, gradients) stays a string
	local function coerce(v)
		if v:match("^%-?%d+$") or v:match("^%-?%d*%.%d+$") then
			return tonumber(v)
		end
		return v
	end

	-- windowrules.conf is intentionally skipped: hyprlang rule syntax doesn't
	-- map cleanly onto hl.config and needs hl.window_rule() instead.
	for _, name in ipairs({ "colors", "layout" }) do
		local file = io.open(dir .. name .. ".conf", "r")
		if file then
			local stack = { root } -- nested-section table stack
			for raw in file:lines() do
				-- Luau makes the loop variable read-only, so trim into a local.
				local line = raw:gsub("#.*$", ""):gsub("^%s+", ""):gsub("%s+$", "")
				if line ~= "" then
					if line:match("^%$") then
						-- variable definition: $name = value
						local k, val = line:match("^%$(%S+)%s*=%s*(.+)$")
						if k then
							vars[k] = val
						end
					elseif line:match("{%s*$") then
						-- section open: "name {"
						local sec = line:match("^(%S+)%s*{")
						local cur = stack[#stack]
						cur[sec] = cur[sec] or {}
						stack[#stack + 1] = cur[sec]
					elseif line:match("^}") then
						stack[#stack] = nil
					else
						-- key = value, with $var substitution; dotted keys
						-- like col.active_border are kept verbatim.
						local k, val = line:match("^(%S+)%s*=%s*(.+)$")
						if k then
							val = val:gsub("%$(%w+)", function(n)
								return vars[n] or ("$" .. n)
							end)
							stack[#stack][k] = coerce(val)
						end
					end
				end
			end
			file:close()
		end
	end

	if next(root) then
		hl.config(root)
	end
end

apply_dms()
