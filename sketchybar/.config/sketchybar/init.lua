local util = require("util")

msg("--default icon.font='PragmataPro Liga:Regular:13'")

local bar = {
	color = "0xFF282828",
	border_color = "0xFFD8A657",
	corner_radius = 8,
	height = 40,
	y_offset = 5,
	border_width = 2,
	sticky = true,
	margin = util.yabai_query("left_padding"),
}

util.set_bar(bar)
util.add_item("hello", "center")
util.set_item("hello", {
    script = os.getenv("CONFIG_DIR") .. "/time.lua",
    update_freq = 30,
	icon = {
		string = "Hello"
	}
})


reg("hello", function (_)
    print("hi")
end)

print(coroutine.resume(co))
