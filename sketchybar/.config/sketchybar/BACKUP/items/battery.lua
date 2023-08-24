local p = require('pallete')

local battery = Item:new {
name = "battery",
	position = "right",
	props = {
		["icon.color"] = p.blue,
		["icon.font"] = Font..":Regular:18",
		["script"] = "/Users/reeperto/.config/sketchybar/plugins/battery.lua",
		["update_freq"] = 30,
		["updates"] = true,
	}
}

battery:push()
