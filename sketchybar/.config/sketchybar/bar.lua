local colors = require("colors")

sbar.default({
    icon = {
        font = "IosevkaTerm Nerd Font:Regular:15.0",
    }
})

sbar.bar({
    height        = 35,
    color         = colors.bar.bg,
    shadow        = false,
    sticky        = true,
    padding_right = 10,
    padding_left  = 10,
    blur_radius   = 20,
    -- topmost       = "window",
})

require("space")

local time = sbar.add("item", "time", {
    position = "center",
    update_freq = 1
})

time:subscribe("routine", function (env)
    time:set({ icon =  os.date() })
end)
