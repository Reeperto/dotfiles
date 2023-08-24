math.randomseed(os.time())

bar.set({
	height = 30,
	y_offset = 10,
	-- sticky = true,
	font_smoothing = true,
	margin = 15,
	color = "#FF141617",
	border_color = "#FFD8A657",
	border_width = 3,
	corner_radius = 8,
})

util.add()

util.click_script("hello", function(env)
	local rand_color = string.format("#FF%06X", math.random(0, 255 ^ 3))
	local anim = util.animate(rand_color, "circ", 30);

	bar.set({
		color = anim,
		border_color = anim,
		height = util.animate(math.random(30, 100), "tanh", 20)
	})
end)
