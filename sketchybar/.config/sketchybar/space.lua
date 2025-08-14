local pallete = require("colors")
local space_icons = {}
local fmt = string.format

for i = 1, 9 do
    space_icons[i] = sbar.add("item", fmt("workspace.%d", i), {
        icon = {
            string = tostring(i),
            color = pallete.bg1
        },
        position = "left",
        padding_left = 10,
        padding_right = 10
    })
end

local space_listener = sbar.add("item", "workspace.listener", { position = "center"})

local old_space = -1

space_listener:subscribe("space_change", function (env)
    local new_space = env.INFO["display-1"]

    if old_space ~= -1 then
        space_icons[old_space]:set({
            icon = {
                color = pallete.bg1
            }
        })

    end

    old_space = new_space

    space_icons[new_space]:set({
        icon = {
            color = pallete.red
        }
    })
end)
