local M = {}

-- local msg = require("luabar").msg
local fmt = string.format;
local concat = table.concat;

---@param property string
---@return string
function M.yabai_query(property)
	return io.popen('yabai -m config ' .. property, "r"):read("*a")
end

---@param table table
---@param prefix string|nil
---@return string
function M.table_to_str(table, prefix)
	local props = {}
	local format_str

	if prefix == nil then
		format_str = "%s='%s'"
	else
		format_str = prefix .. ".%s='%s'"
	end

	for prop, value in pairs(table) do
		if type(value) == "table" then
			props[#props + 1] = M.table_to_str(value, prop)
		else
			props[#props + 1] = fmt(format_str, prop, tostring(value))
		end
	end

	return concat(props, " ");
end

---@param props table
function M.set_bar(props)
	msg("--bar " .. M.table_to_str(props))
end

---@param name string
---@param position
--- |"left"
--- |"right"
--- |"center"
--- |"q"
--- |"e"
---@param type nil
--- |"item"
--- |"graph"
--- |"slider"
--- |"bracket"
--- |"alias"
function M.add_item(name, position, type)
	if type == nil then
		msg(fmt("--add item %s %s", name, position))
	else
		msg(fmt("--add %s %s %s", type, name, position))
	end
end

function M.add_event(name, ns_notification)
	if ns_notification == nil then
		msg(fmt("--add event %s", name))
	else
		msg(fmt("--add event %s %s", name, ns_notification))
	end
end

---@param name string
---@param props table
function M.set_item(name, props)
	msg(fmt("--set %s %s", name, M.table_to_str(props)))
end

---@param name string
---@param ... string[]
function M.subscribe(name, ...)
	msg(fmt("--subscribe %s %s", name, table.concat({...}, " ")))
end

---@param script string
---@return string
function M.osascript(script)
	return io.popen(fmt("osascript -e '%s'", script), "r"):read("*a")
end

return M
