local colors = require("colors")

sbar.bar({
    height = 35,
    color = colors.bar.bg,
    shadow = true,
    sticky = true,
    padding_right = 10,
    padding_left = 10,
    blur_radius=20,
    topmost="window",
})
