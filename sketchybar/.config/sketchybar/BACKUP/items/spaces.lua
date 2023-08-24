local p = require("pallete")
local space = require("lib.space")

local space_icons = { " ", " ", " ", " ", " ", " " }

for i = 1, 6 do
	local desktop_space = space:new {
		name = "space" .. i,
		position = "left",
		props = {
			["associated_space"] = i,
			["icon"] = space_icons[i],
			["icon.color"] = p.gray,
			["icon.font"] = Font..":Bold:20",
			["icon.padding_right"] = 10,
			["icon.highlight_color"] = p.green,
			["label.drawing"] = false
		}
	}

	desktop_space:push()
end
