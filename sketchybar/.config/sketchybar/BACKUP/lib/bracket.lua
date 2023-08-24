--- @class Bracket: SketchObject
--- @field members string[]

local u = require("lib.util")

--- @class Bracket
Bracket = require("lib.object"):new({
	members = {},
})

function Bracket:add()
	u.execute("--add bracket " .. self.name, self.members)
end

return Bracket
