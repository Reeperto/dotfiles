local p = require("pallete")
local bar = require("lib.bar")

-- Setup helper
_ = io.popen("killall helper", "r"):close()
_ = io.popen("./helper/helper git.reeperto.helper > /dev/null 2>&1 &"):close()

-- Global options
Font = "PragmataPro Liga"
ItemPadding = 3
BackgroundPadding = 10

local main_bar = {
  ["height"] = 35,
  ["color"] = p.black,
  ["shadow"] = false,
  ["position"] = "top",
  ["sticky"] = true,
}

local defaults = {
  ["updates"] = "when_shown",
  ["icon.font"] = Font .. ":Bold:18.0",
  ["icon.color"] = p.white,
  ["icon.padding_left"] = ItemPadding,
  ["icon.padding_right"] = ItemPadding,
  ["label.font"] = Font .. ":Regular:13.0",
  ["label.color"] = p.white,
  ["label.padding_left"] = ItemPadding,
  ["label.padding_right"] = ItemPadding,
  ["background.height"] = 28,
  ["background.border_width"] = 2,
  ["background.corner_radius"] = 0,
  ["popup.background.color"] = p.black,
  ["popup.background.shadow.drawing"] = false,
}

bar.create_bar(main_bar)
bar.set_defaults(defaults)

-- Items that need scripts loaded at start

require("items.spaces")
-- require("items.course")
require("items.time")
require("items.battery")
require("items.current_app")

bar.update_bar()

require('lib.util').dump(getmetatable(require("lib.object")))

-- Items that need scripts not loaded immediately

-- require("items.volume")
