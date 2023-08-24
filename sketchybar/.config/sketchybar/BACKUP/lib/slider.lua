--- @class Slider: Item
--- @field width number

local u = require("lib.util")

--- @class Slider
Slider = require("lib.item"):new({
	width = 100,
	props = {}
})

function Slider:add()
  send("--add slider " .. self.name .. " " .. self.position .. " " .. self.width)
end

function Slider:update()
	u.execute("--set " .. self.name .. " width=" .. tostring(self.width) .. " ", self.props)
end

return Slider
