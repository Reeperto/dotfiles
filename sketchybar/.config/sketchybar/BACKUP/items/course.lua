local p = require('pallete')

local course = Item:new {
	name = "course",
	position = "center",
	props = {
		["icon.color"] = p.blue,
		["icon.font"] = Font..":Regular:18",
		["script"] = "/Users/reeperto/.config/sketchybar/plugins/course",
		["update_freq"] = 60,
		["updates"] = true,
	}
}

course:push()
