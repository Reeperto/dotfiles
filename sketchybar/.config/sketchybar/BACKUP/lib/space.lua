--- @class Space: Item
-- # Associate mission control spaces with an item
--
-- The space component overrides the definition of the following properties:
-- * `associated_space`: Which space this item represents
--
-- * _(optional)_ `associated_display`: On which display the `associated_space` is shown. The `associated_space` property must be set to properly associate this item with the corresponding mission control space. Optionally, you can provide an `associated_display` to force a space item to stay on a specific display, otherwise the item will draw on the screen on which the space is currently located. 

Space = require("lib.item"):new({})

function Space:add()
	send("--add space " .. self.name .. " " .. self.position)
end

return Space
