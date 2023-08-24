local p = require("pallete")
local item = require("lib.item")
local slider = require("lib.slider")

local volume = item:new({
	name = "volume",
	position = "right",
	props = {
		["icon"] = " ",
		["icon.font"] = Font..":Bold:20",
		["click_script"] = "sketchybar --set volume popup.drawing=toggle",
		["popup.align"] = "center",
		["popup.y_offset"] = 10,
		["popup.background.border_color"] = p.magenta,
		["popup.background.border_width"] = 2,
		["popup.drawing"] = false,
		["popup.horizontal"] = true,
	}
})

local volume_slider = slider:new({
  name = "volume.slider",
  position = "popup.volume",
  width = 200,
  props = {
    ["slider.knob"] = " ",
    ["slider.knob.align"] = "right",
    ["slider.background.color"] = p.black,
    ["slider.highlight_color"] = p.yellow,
    ["slider.knob.font"] = Font..":Bold:20",
    ["script"] = "/Users/reeperto/.config/sketchybar/plugins/volume",
    ["updates"] = false,
  },
})


volume:push()
volume_slider:push()
volume_slider:subscribe("mouse.clicked")
