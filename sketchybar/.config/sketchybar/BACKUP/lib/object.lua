--- Abstract SketchyBar Object
-- @type SketchObject

local u = require("lib.util")

--- @class SketchObject
--- @field name string
--- @field props table
SketchObject = {
	name = "",
	props = {}
}

--- @param object table
--- @return SketchObject
-- Creates SketchObject from input parameters
function SketchObject:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end

-- Add object to sketchybar and apply properties
function SketchObject:push()
	self:add()
	self:update()
end

--- Add object to sketchybar
function SketchObject:add()
	assert(false, "Not implemented for SketchObject. Please use a specific object class")
end

-- Pushes all properties of object to sketchybar.
function SketchObject:update()
	u.execute("--set " .. self.name .. " ", self.props)
end

--- @param event string
-- Subscribes object to the given `event`
function SketchObject:subscribe(event)
  send("--subscribe " .. self.name .. " " .. event)
end

return SketchObject
