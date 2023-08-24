-- Item
---@module "lib.object"

local u = require("lib.util")

--- @class Item: SketchObject
--- @field name string
--- @field position string
--- @field props table
Item = require("lib.object"):new({
	position = "",
})

function Item:add()
	send("--add item " .. self.name .. " " .. self.position)
end

return Item
