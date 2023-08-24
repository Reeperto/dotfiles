local p = require("pallete")
local item = require("lib.item")
local u = require("lib.util")

local time = item:new {
	name = "date.time",
	position = "right",
	props = {
		["script"] = u.plugin("time -t"),
		["icon.color"] = p.green,
		["icon.font"] = Font..":Bold:15",
		["update_freq"] = 1
	}
}

local day = item:new {
	name = "date.day",
	position = "right",
	props = {
		["script"] = u.plugin("time -d"),
		["icon.color"] = p.blue,
		["icon.font"] = Font..":Bold:15",
		["update_freq"] = 1
	}
}

day:push()
time:push()
