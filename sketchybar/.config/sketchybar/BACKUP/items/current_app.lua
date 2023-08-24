local item = require("lib.item")
local p = require("pallete")

local current_app = item:new {
	name = "current_app",
	position = "left",
	props = {
		["mach_helper"] = "git.reeperto.helper",
		["label.font"] = Font .. ":Bold:15.0",
		["label.color"] = p.yellow
	}
}

current_app:push()
current_app:subscribe("front_app_switched")
