local M = {}

local u = require("lib.util")

---Initialize main bar
---@param bar table
function M.create_bar(bar)
	u.execute("--bar ", bar)
end

---Update all items and run all scripts on bar
function M.update_bar()
	send("--update")
end

---Set Sketchybar global defaults
---@param defaults table
function M.set_defaults(defaults)
	u.execute("--default ", defaults)
end

return M
